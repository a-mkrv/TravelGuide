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
    var pressure: Int = 0
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
        pressure = weather["pressure"] as? Int ?? 0
        description = weather["description"] as? String ?? "Unknown"
        
        if description.contains("cloud") {
            icon = "cloud"
        } else if description.contains("sun") {
            icon = "sun"
        } else if description.contains("rain") {
            icon = "rain"
        } else if description.contains("clear") {
            icon = "clear"
        } else {
            icon = "clear"
        }
    }
}
