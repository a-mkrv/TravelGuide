//
//  SightViewModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import RealmSwift

class SightViewModel {
    
    var sights = [Sight]()
    var diplaySights = [Sight]()    
    let results = try! Realm().objects(CityRealmModel.self)
    
    func extractRealmSights(cityRealmModel: CityRealmModel) {
        
        for res in cityRealmModel.sights {
            if let sight = Sight(sRealm: res) {
                self.sights.append(sight)
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
        curCity.country = 1
        
        for s in sights {
            let sr = SightRealmModel(sight: s)
            DBManager.sharedInstance.addSigthToCity(city: curCity, object: sr)
        }
        
        DBManager.sharedInstance.addCity(object: curCity)
    }
    
    func getAllSights(_ city_id: NSNumber, completion: @escaping () -> ()) {
        sights.removeAll()
        
        if let cityModel = DBManager.sharedInstance.getCityById(id: Int(truncating: city_id)), CurrentUser.sharedInstance.city?.id == city_id {
            CurrentUser.sharedInstance.city?.isDownload = true
            extractRealmSights(cityRealmModel: cityModel)
            completion()
        } else {
            APIService.shared.getSights(city_id){ response, error in
                
                if error != nil || response == nil || response?.status == "error"  {
                    return
                }
                
//                for object in (response?.data as? Json)! {
//                    if let sight = Sight(json: object.value as? Json) {
//                        self.sights.append(sight)
//                    }
//                }
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
        
        let url = URL(string: sight.imagesURL.first!)
        cell.pImage.kf.setImage(with: url)
        
        return cell
    }
}
