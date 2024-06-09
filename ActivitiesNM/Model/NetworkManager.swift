//
//  ActivitiesManager.swift
//  ActivitiesNM
//
//  Created by Konstantin on 27.04.2024.
//

import Foundation

protocol NetworkManagerDelegate {
    func didGetActivities(_ activities: [ActivityData])
    func didFailWithError(_ error: Error)
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    func fetchActivities() {
        let urlString = "https://activitiesnm-default-rtdb.firebaseio.com/test.json"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error)
                return
            }
            guard let safeData = data, let activities = self.parseJSON(safeData) else { return }
            self.delegate?.didGetActivities(activities)
        }
        task.resume()
    }
    
    private func parseJSON(_ activitiesData: Data) -> [ActivityData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivitiesData.self, from: activitiesData)
            return decodedData.activities
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    func loadImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
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
