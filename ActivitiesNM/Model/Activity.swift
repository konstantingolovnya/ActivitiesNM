//
//  Activities.swift
//  ActivitiesNM
//
//  Created by Konstantin on 26.02.2024.
//

import Foundation

struct Activity: Hashable {
    
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
    
    var name = ""
    var type = ""
    var location = ""
    var description = ""
    var phoneNumber = ""
    var isFavorite = false
    var rating: Rating?
}
