//
//  Sight + Realm.swift
//  TravelGuide
//
//  Created by Anton Makarov on 16/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import RealmSwift

class RealmString: Object {
    @objc dynamic var stringValue = ""
}

class SightRealmModel: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var cost = 0.0
    @objc dynamic var phoneNumber: String? = nil
    @objc dynamic var webSite: String? = nil
    @objc dynamic var descript: String? = nil
    @objc dynamic var history: String? = nil
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
    var tags = List<RealmString>()
    var imagesURL = List<RealmString>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(sight: Sight) {
        self.init()

        id = sight.id.intValue
        name = sight.name
        type = sight.type
        rating = sight.rating
        cost = sight.cost ?? 0
        phoneNumber = sight.phoneNumber
        webSite = sight.webSite
        descript = sight.descript
        history = sight.history
        latitude = sight.coordinate.latitude
        longitude = sight.coordinate.longitude
        tags.append(objectsIn: sight.tags.map { RealmString(value: [$0]) })
        imagesURL.append(objectsIn: sight.imagesURL.map { RealmString(value: [$0]) })
    }
}
