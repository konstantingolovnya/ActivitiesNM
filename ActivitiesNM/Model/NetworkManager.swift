//
//  ActivitiesManager.swift
//  ActivitiesNM
//
//  Created by Konstantin on 27.04.2024.
//

import Foundation

protocol NetworkManagerDeligate {
    func didGetActivities(activities: [ActivityData])
    func didFailWithError(error: Error)
}

struct NetworkManager {
    
    var deligate: NetworkManagerDeligate?
    
    func fetchActivities() {
        let urlString = "https://activitiesnm-default-rtdb.firebaseio.com/test.json"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.deligate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let activities = self.parseJSON(safeData) {
                        self.deligate?.didGetActivities(activities: activities)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ activitiesData: Data) -> [ActivityData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivitiesData.self, from: activitiesData)
            let activities = decodedData.activities
            return activities
        } catch {
            deligate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func getImage(urlString: String, completion: @escaping (Data) -> Void) {
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let data = data {
                    completion(data)
                }
            }.resume()
        }
    }
    
    
    func loadImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let backgroundQueue = DispatchQueue(label: "background_queue", qos: .background)
            backgroundQueue.async {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    
//    func getImage(urlString: String) async throws -> Data {
//        var imageData = Data()
//        if let url = URL(string: urlString) {
////            let request = URLRequest(url: url)
//            let (data, _) = try await URLSession.shared.data(from: request)
//            imageData = data
//        }
//        return imageData
//    }
}
