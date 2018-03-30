//
//  SightViewModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Nuke

class SightViewModel {
    
    var sights = [Sight]()
    var manager = Nuke.Manager.shared
    
    func getAllSights(_ city_id: NSNumber, completion: @escaping () -> ()) {
        sights.removeAll()
        
        APIService.shared.getSights(city_id){ response, error in
            
            guard error == nil || response != nil || response!["status"] as? String == "error" else {
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
    
    func cellInstance(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SightCell", for: indexPath) as! SightCollectionViewCell
        
        let sight = self.sights[indexPath.row]
        cell.sightId = sight.id
        cell.pName.text = sight.name
        cell.pType.text = sight.type
        cell.indexCell = indexPath.row
        
        let request = Request(url: URL(string: "https://img-fotki.yandex.ru/get/197852/27854841.58f/0_ef76b_fb4fa46e_XXXL.jpg")!)
        manager.loadImage(with: request, into: cell.pImage)
        
        //cell.pImage.loadImageUsingCacheWithUrlString(urlString: "")
        
        
        return cell
    }
}
