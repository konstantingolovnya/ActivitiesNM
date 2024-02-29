//
//  Activities.swift
//  ActivitiesNM
//
//  Created by Konstantin on 26.02.2024.
//

import Foundation

struct Activity: Hashable {
    var name: String
    var type: String
    var location: String
    var isFavorite: Bool
    
    init(name: String, type: String, location: String, isFavorite: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.isFavorite = isFavorite
    }
}
