//
//  Trip.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

fileprivate struct DataKeys {
    static let id = "trip_id"
    static let name = "name"
    static let descript = "description"
    static let tags = "tags"
    static let imageURL = "imageURL"
    static let likes = "likes"
}

// Trip Model
struct Trip: JsonObject {
    let id: NSNumber
    let name: String
    let descript: String
    let tags: [String]
    let imageURL: String
    let likes: NSNumber
    var places: [Sight] = []
    let reuseIdentifier = "TripCell"
}

// Mark: - extension Trip
extension Trip {
    init?(json: Json?) {
        guard let json = json,
            let id = json[DataKeys.id] as? NSNumber,
            let name = json[DataKeys.name] as? String,
            let descript = json[DataKeys.descript] as? String,
            let tags = json[DataKeys.tags] as? [String],
            let imageURL = json[DataKeys.imageURL] as? String,
            let likes = json[DataKeys.likes] as? NSNumber
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.descript = descript
        self.tags = tags
        self.imageURL = imageURL
        self.likes = likes
    }
}
