//
//  DBManager.swift
//  TravelGuide
//
//  Created by Anton Makarov on 17/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import RealmSwift

class DBManager {
    
    static let sharedInstance = DBManager()
    
    init() {
        self.configRealm()
    }
    
    // Realm database configuration
    private func configRealm() {
        let config = Realm.Configuration( schemaVersion: 1, migrationBlock: {
            migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
                Logger.info(msg: "Sсheme less than 1")
            }
        })
        
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }
    
    private func realmObject() throws -> Realm {
        let realm = try Realm()
        return realm
    }
    
    private func storeObject<T: Object>(_ object: T, withUpdate: Bool = true, to: Object? = nil) {
        do {
            if let realm = try? realmObject() {
                try realm.write {
                    realm.add(object, update: withUpdate)
                }
            }
        } catch _ {
            Logger.error(msg: "Error store/update object")
        }
    }
    
    private func deleteObject<T: Object>(_ object: T) {
        do {
            if let realm = try? realmObject() {
                try realm.write {
                    realm.delete(object)
                }
            }
        } catch _ {
            Logger.error(msg: "Error delete object")
        }
    }
    
    private func getObjects<T: Object>(_ object: T.Type) -> [T]? {
        if let realm = try? realmObject() {
            let objs = realm.objects(object).map{ $0 }
            return Array(objs)
        }
        
        return nil
    }
    
    private func getObjectByID<T: Object>(_ object: T.Type, id: Int) -> T? {
        if let realm = try? realmObject() {
            return realm.object(ofType: object, forPrimaryKey: id)
        }
        
        return nil
    }
    
    // Full database cleaning
    private func clearAllData() {
        do {
            if let realm = try? realmObject() {
                try realm.write {
                    realm.deleteAll()
                }
            }
        } catch _ {
            Logger.error(msg: "Error clear all data")
        }
    }
}

extension DBManager {
    func addCity(object: CityRealmModel) {
        storeObject(object)
        Logger.info(msg: "Added new city object - (\(object.name))")
    }
    
    func deleteCity(object: CityRealmModel) {
        deleteObject(object)
        Logger.info(msg: "Deleted city object - (\(object.name))")
    }
    
    func getCityById(id: Int) -> CityRealmModel? {
        return getObjectByID(CityRealmModel.self, id: id) ?? CityRealmModel()
    }
    
    func addSigthToCity(city: CityRealmModel, object: SightRealmModel) {
        do {
            if let realm = try? realmObject() {
                try realm.write {
                    city.sights.append(object)
                }
            }
        } catch _ {
    
        }
    }
    
    func removeDataBase() {
        clearAllData()
    }
}
