//
//  WeatherViewModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 02/06/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherViewModel {
    
    func getWeatherOfCity(name: String, period: WeatherPeriod, callBack: @escaping (WeatherModel?) -> Void) {
        
        switch period {
        case .Day:
            WeatherService.shared.getToday(city: name, completionHandler: { (response, error) in
                guard error == nil || response != nil else {
                    Logger.error(msg: "Failed to get weather data")
                    callBack(nil)
                    return
                }
                
                callBack(response)
            })

        case .Week: break
        
        }
    }
    
}

