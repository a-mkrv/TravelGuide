//
//  SightViewModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import RealmSwift
import Nuke

class SightViewModel {
    
    var sights = [Sight]()
    var diplaySights = [Sight]()
    
    var manager = Nuke.Manager.shared
    let results = try! Realm().objects(CityRealmModel.self)
    
    func extractRealmSights(byCityId: Int) {

        if let curCity = DBManager.sharedInstance.getCityById(id: byCityId) {
            for res in curCity.sights {
                if let sight = Sight(sRealm: res) {
                    self.sights.append(sight)
                }
            }
        }
    }
    
    func populateRealmSights() {
        guard sights.count > 0 else {
            return
        }
        
        let curCity = CityRealmModel()
        curCity.id = CurrentUser.sharedInstance.city?.id as! Int
        curCity.name = (CurrentUser.sharedInstance.city?.name)!
        curCity.country = "Russia"
        
        for s in sights {
            let sr = SightRealmModel(sight: s)
            DBManager.sharedInstance.addSigthToCity(city: curCity, object: sr)
        }
        
        DBManager.sharedInstance.addCity(object: curCity)
    }
    
    func getAllSights(_ city_id: NSNumber, completion: @escaping () -> ()) {
        sights.removeAll()
        
        
        if (CurrentUser.sharedInstance.city?.id == city_id) && (!APIService.isConnectedToInternet || results.count > 0) {
            extractRealmSights(byCityId: city_id.intValue)
            completion()
        } else {
            APIService.shared.getSights(city_id){ response, error in
                
                if error != nil || response == nil || response!["status"] as? String == "error"  {
                    return
                }
                
                for object in (response!["data"] as? Json)! {
                    if let sight = Sight(json: object.value as? Json) {
                        self.sights.append(sight)
                    }
                }
                completion()
            }
        }
    }
    
    func cellInstance(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SightCell", for: indexPath) as! SightCollectionViewCell
        
        let sight = self.diplaySights[indexPath.row]
        cell.sightId = sight.id
        cell.pName.text = sight.name
        cell.pType.text = sight.type
        cell.indexCell = indexPath.row
        cell.cost.text = sight.cost
        
        let request = Request(url: URL(string: sight.imagesURL.first!)!)
        manager.loadImage(with: request, into: cell.pImage)
        
        return cell
    }
}
