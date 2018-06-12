//
//  CityViewModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 22.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Nuke

class CityViewModel {
    
    var cities = [City]()
    var manager = Nuke.Manager.shared
    
    func getAllCity(completion: @escaping () -> ()) {
        APIService.shared.getCities{ response, error in
            
            guard error == nil || response != nil || response!["status"] as? String == "error" else {
                return
            }
            
            for object in (response!["data"] as? Json)! {
                if let city = City(json: (object.value as! Json)) {
                    self.cities.append(city)
                }
            }
            completion()
        }
    }
    
    func cellInstance(_ tableView: UITableView, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityListTableViewCell
        
        let city = self.cities[indexPath.row]
        cell.cityName.text = city.name
        manager.loadImage(with: Request(url: URL(string: city.urlImage)!), into: cell.cityImage)
        
        return cell
    }
}
