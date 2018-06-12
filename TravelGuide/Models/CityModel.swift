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
    static let urlImage = "url_photo"
}

struct City {
    let id: NSNumber
    let country: NSNumber
    let name: String
    let sights: [Sight]
    var isDownload: Bool = false
    let urlImage: String
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
        self.urlImage = json[DataKeys.urlImage] as? String ?? "https://img-fotki.yandex.ru/get/197852/27854841.58f/0_ef76b_fb4fa46e_XXXL.jpg"
    }
    
    init?(dictionary : [String : Any]) {
        guard let id = dictionary["id"] as? NSNumber,
            let name = dictionary["name"] as? String,
            let urlImage = dictionary["url"] as? String,
            let isDownload = dictionary["isDownload"] as? Bool else { return nil }
        
        self.init(id: id, country: 1, name: name, sights: [], isDownload: isDownload, urlImage: urlImage)
    }
    
    var propertyList : [String : Any] {
        return ["id" : id, "name" : name, "isDownload" : isDownload, "url" : urlImage]
    }
}
