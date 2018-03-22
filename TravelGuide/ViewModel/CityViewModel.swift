//
//  CityViewModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 22.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class CityViewModel {
    
    var cities = [City]()
    
    func getAllCity(completion: @escaping () -> ()) {
        APIService.shared.getCities{ responseObject, error in
            if let jsonObject = responseObject {
                for object in jsonObject {
                    if let city = City(json: (object.value as! Json)) {
                        self.cities.append(city)
                    }
                }
            }
            completion()
        }
    }
    
    func cellInstance(_ tableView: UITableView, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityListTableViewCell
        
        let city = self.cities[indexPath.row]
        cell.cityName.text = city.name
        //cell.cityImage.image = UIImage(named: city.imege_url) // change no real image
        
        return cell
    }
}
