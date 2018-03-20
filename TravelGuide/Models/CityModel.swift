//
//  CityModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

fileprivate struct DataKeys {
    static let id = "place_id"
    static let name = "name"
    static let country = "country"
    static let sight = "sight"
}

struct City: JsonObject {
    let id: NSNumber
    let name: String
    let country: String
    let sights: [Sight]
}

// Mark: - extension City
extension City {
    init?(json: Json?) {
        guard let json = json,
            let id = json[DataKeys.id] as? NSNumber,
            let name = json[DataKeys.name] as? String,
            let country = json[DataKeys.country] as? String,
            let sights = json[DataKeys.sight] as? [Sight]
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.country = country
        self.sights = sights
    }
}
