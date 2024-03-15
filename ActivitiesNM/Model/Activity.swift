//
//  Activities.swift
//  ActivitiesNM
//
//  Created by Konstantin on 26.02.2024.
//

import CoreData

public class Activity: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var location: String
    @NSManaged public var phone: String
    @NSManaged public var summary: String
    @NSManaged public var image: Data
    @NSManaged public var ratingText: String?
    @NSManaged public var isFavorite: Bool
}

extension Activity {
    enum Rating: String {
            case awesome, good, okay, bad, terrible
    
            var image: String {
                switch self {
                case .awesome: return "love"
                case .good: return "cool"
                case .okay: return "happy"
                case .bad: return "sad"
                case .terrible: return "angry"
                }
            }
        }
    
    var rating: Rating? {
        get {
            guard let ratingText = ratingText else {
                return nil
            }
            return Rating(rawValue: ratingText)
        }
        set {
            self.ratingText = newValue?.rawValue
        }
    }
}
