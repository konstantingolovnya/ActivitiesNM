//
//  ActivitiesData.swift
//  ActivitiesNM
//
//  Created by Konstantin on 27.04.2024.
//

import Foundation

struct ActivitiesData: Codable {
    let activities: [ActivityData]
}

struct ActivityData: Codable, Hashable {
    let image: String?
    let location: String?
    let name: String?
    let phone: String?
    let summary: String?
    let type: String?
}
