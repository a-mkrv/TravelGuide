//
//  DBManager.swift
//  TravelGuide
//
//  Created by Anton Makarov on 17/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import RealmSwift

class DBManager {
    
    private var database: Realm
    static let sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func addCity(object: CityRealmModel) {
        try! database.write {
            database.add(object, update: true)
            Logger.info(msg: "Added new city object - (\(object.name))")
        }
    }
    
    func deleteCity(object: CityRealmModel) {
        try! database.write {
            database.delete(object)
            Logger.info(msg: "Deleted city object - (\(object.name))")
        }
    }
    
    func getCityById(id: Int) -> CityRealmModel? {
        return database.object(ofType: CityRealmModel.self, forPrimaryKey: id)
    }
    
    func addSigthToCity(city: CityRealmModel, object: SightRealmModel) {
        try! database.write {
            city.sights.append(object)
        }
    }
    
    func deleteAllFromDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    
}
