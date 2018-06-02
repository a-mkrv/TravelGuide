//
//  WeatherModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 02/06/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

struct WeatherModel {
    var cityName: String = ""
    var temperature: String!
    var description: String
    var pressure: Float = 0.0
    var humidity: Float = 0.0
    var speed: Float = 0.0
    var icon: String
}

extension WeatherModel {
    
    init?(json: Json?, name: String) {
        guard let json = json else {
                return nil
        }
        
        cityName = name
        temperature = String((json["main"]!["temp"] as! Double) - 273)
        humidity = json["main"]!["humidity"] as? Float ?? 0.0
        speed = json["wind"]!["speed"] as? Float ?? 0.0
        
        let weather = json["weather"]![0] as! Json
        pressure = weather["pressure"] as? Float ?? 0.0
        description = weather["description"] as? String ?? "Unknown"
        icon = weather["icon"] as? String ?? "none"
    }
}
