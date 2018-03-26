//
//  SightViewModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class SightViewModel {
    
    var sights = [Sight]()
    
    func getAllSights(completion: @escaping () -> ()) {
        APIService.shared.getSights{ response, error in
            
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
        cell.pName.text = sight.name
        cell.pType.text = sight.type
        cell.pDistance.text = "10 km"
        cell.pImage.image = sight.images.first?.image ?? UIImage(named: "nn")
        
        return cell
    }
}
