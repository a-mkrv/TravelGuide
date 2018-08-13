//
//  City + Realm.swift
//  TravelGuide
//
//  Created by Anton Makarov on 16/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import RealmSwift

class CityRealmModel: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var country = 0
    @objc dynamic var image = "image"

    var sights = List<SightRealmModel>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
