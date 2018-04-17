//
//  PlaceModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 19.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import CoreLocation
import Nuke

var manager = Nuke.Manager.shared

fileprivate struct DataKeys {
    static let id = "id_sight"
    static let name = "name"
    static let type = "type"
    static let rating = "rating"
    static let cost = "cost"
    static let tags = "tags"
    static let coordinate = "coordinate"
    static let imageURL = "photo_urls"
    static let phoneNumber = "phone_number"
    static let webSite = "web_site"
    static let descript = "description"
    static let history = "history"
}

struct Sight {
    let id: NSNumber
    let name: String
    let type: String
    let rating: Double
    let cost: Double?
    let tags: [String]
    let imagesURL: [String]
    var imagesJPG: [UIImageView]
    let coordinate: CLLocationCoordinate2D
    let phoneNumber: String?
    let webSite: String?
    let descript: String?
    let history: String?
    let reuseIdentifier = "SightCell"
}

// Mark: - extension Sight
extension Sight {
    
    init?(sRealm: SightRealmModel?) {
        guard let realm = sRealm else {
                return nil
        }
        
        self.id = NSNumber(value: realm.id)
        self.name = realm.name
        self.type = realm.type
        self.rating = realm.rating
        self.tags = realm.tags.map { $0.stringValue }
        self.imagesURL = realm.imagesURL.map { $0.stringValue }
        self.imagesJPG = []
        
        self.cost = realm.cost
        self.phoneNumber = realm.phoneNumber ?? nil
        self.webSite = realm.webSite ?? nil
        self.descript = realm.descript ?? nil
        self.history = realm.history ?? nil

        let lat = realm.latitude
        let long = realm.longitude
        self.coordinate = CLLocationCoordinate2D(latitude: lat as CLLocationDegrees, longitude: long as CLLocationDegrees)
    }
    
    init?(json: Json?) {
        guard let json = json,
            let id = json[DataKeys.id] as? NSNumber,
            let name = json[DataKeys.name] as? String,
            let coordinate = json[DataKeys.coordinate] as? Json
            else {
                return nil
        }
 
        self.id = id
        self.name = name
        self.type = json[DataKeys.type] as? String ?? "None"
        self.rating = json[DataKeys.rating] as? Double ?? 4.0
        self.tags = json[DataKeys.tags] as? [String] ?? []
        self.imagesURL = json[DataKeys.imageURL] as? [String] ?? ["https://img-fotki.yandex.ru/get/197852/27854841.58f/0_ef76b_fb4fa46e_XXXL.jpg"]
        self.imagesJPG = []
        
        self.cost = json[DataKeys.cost] as? Double ?? nil
        self.phoneNumber = json[DataKeys.phoneNumber] as? String ?? nil
        self.webSite = json[DataKeys.webSite] as? String ?? nil
        self.descript = json[DataKeys.descript] as? String ?? nil
        self.history = json[DataKeys.history] as? String ?? nil
        
        //if let img = imagesURL.first, img != "" {
        //var request = Request(url: URL(string: "")!)
        //manager.loadImage(with: request, into: img)
        
        let lat = (coordinate["lat"] as! NSString).doubleValue
        let long = (coordinate["long"]  as! NSString).doubleValue
        self.coordinate = CLLocationCoordinate2D(latitude: lat as CLLocationDegrees, longitude: long as CLLocationDegrees)
    }
}

