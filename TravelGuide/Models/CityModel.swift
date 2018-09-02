//
//  CityModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import ObjectMapper

struct City: Mappable {
    var id: NSNumber!
    var country: NSNumber!
    var name: String!
    var sights: [Sight] = []
    var urlImage: String!
    var isDownload: Bool = false
}

// Mark: - extension City
extension City {
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id <- map["id_town"]
        name <- map["name"]
        country <- map["country"]
        urlImage <- map["url_photo"]
        sights = []
    }
    
    init?(dictionary : [String : Any]) {
        guard let id = dictionary["id"] as? NSNumber,
            let name = dictionary["name"] as? String,
            let urlImage = dictionary["url"] as? String,
            let isDownload = dictionary["isDownload"] as? Bool else { return nil }
        
        self.init(id: id, country: 1, name: name, sights: [], urlImage: urlImage, isDownload: isDownload)
    }
    
    var propertyList : [String : Any] {
        return ["id" : id, "name" : name, "isDownload" : isDownload, "url" : urlImage]
    }
}

