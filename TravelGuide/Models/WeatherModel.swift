//
//  WeatherModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 02/06/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherModel: Mappable {

    var weather: Weather!
    var main: Temperature!
    
    var cityName: String!
    var speed: Float!
    var icon: String!

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        weather <- map["weather.0"]
        main <- map["main"]
        cityName <- map["name"]
        speed <- map["wind.speed"]
        iconNameFor(id: weather.id)
    }
    
    func iconNameFor(id: Int)  {
        switch id {
        case 200..<300: icon = "storm.png"
        case 300..<600: icon = "rain.png"
        case 600..<700: icon = "snow.png"
        case 800:       icon = "sun.png"
        case 801:       icon = "clear.png"
        case 802..<900: icon = "cloud.png"
        default:
            icon = "sun.png"
        }
    }
}

struct Temperature: Mappable {
    
    var pressure: Int!
    var humidity: Int!
    var temp: Double!

    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        temp <- map["temp"]
    }
}

struct Weather: Mappable {
    
    var id: Int!
    var description: String!

    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
    }
}
