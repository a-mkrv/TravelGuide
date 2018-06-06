//
//  CityModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

fileprivate struct DataKeys {
    static let id = "id_town"
    static let name = "name"
    static let country = "country"
    static let sight = "sight"
}

struct City {
    let id: NSNumber
    let country: NSNumber
    let name: String
    let sights: [Sight]
    var isDownload: Bool = false
}

// Mark: - extension City
extension City {
    init?(json: Json?) {
        guard let json = json,
            let id = json[DataKeys.id] as? NSNumber,
            let name = json[DataKeys.name] as? String
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.country = json[DataKeys.country] as? NSNumber ?? 1
        self.sights = []
    }
    
    init?(dictionary : [String : Any]) {
        guard let id = dictionary["id"] as? NSNumber,
            let name = dictionary["name"] as? String,
            let isDownload = dictionary["isDownload"] as? Bool else { return nil }
        
        
        self.init(id: id, country: 1, name: name, sights: [], isDownload: isDownload)
    }
    
    var propertyList : [String : Any] {
        return ["id" : id, "name" : name, "isDownload" : isDownload]
    }
}
