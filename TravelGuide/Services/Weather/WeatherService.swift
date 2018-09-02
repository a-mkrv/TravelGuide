//
//  WeatherModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 02/06/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

enum WeatherPeriod {
    case Day;
    case Week;
}

class WeatherService {
    
    private var jsonDict: Json?
    
    fileprivate let urlOneDay = "http://api.openweathermap.org/data/2.5/weather"
    fileprivate let urlForecast = "http://api.openweathermap.org/data/2.5/forecast/daily"
    fileprivate let key = "ac11292d4a7d8dd94b3189008a5601ed"
    
    var temperature: String?
    var weather: String?
    
    static let shared = WeatherService()

    func getToday(city: String, completionHandler: @escaping completeRequest<WeatherModel>) {
        let parameters: Json = ["APPID" : key as AnyObject, "q" : city as AnyObject]
        APIService.shared.getWeather(url: urlOneDay, parameters: parameters, completionHandler: completionHandler)
    }
    
    func weeklyForecast(city: String, completionHandler: @escaping completeRequest<WeatherModel>) {
        let regionForecast = city + ",RU"
        let parameters: Json = ["APPID" : key as AnyObject, "q" : regionForecast as AnyObject]
        APIService.shared.getWeather(url: urlOneDay, parameters: parameters, completionHandler: completionHandler)
    }
}

