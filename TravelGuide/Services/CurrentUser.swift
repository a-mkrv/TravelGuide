//
//  ObjectManager.swift
//  TravelGuide
//
//  Created by Anton Makarov on 17/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import Nuke

class CurrentUser {
    
    static let sharedInstance = CurrentUser()
    
    var login: String? = nil {
        didSet {
            UserDefaults.standard.setUserLogin(login: login!)
        }
    }

    var isLogin: Bool = false {
        didSet {
            UserDefaults.standard.setIsLoggedIn(value: isLogin)
        }
    }
    
    var token: String? = nil {
        didSet {
            UserDefaults.standard.setUserToken(token: token!)
        }
    }
    
    var city: City?
    var categories: [String] = []
    
    private init() {}
    
    func setCurrentCity(city: City) {
        self.city = city
        UserDefaults.standard.setCurrentCity(cityId: city.id)
    }
    
    func getCurrentCity() -> NSNumber {
        return UserDefaults.standard.getCurrentCityId()
    }
    
    func logOut() {
        city = nil
        isLogin = false
        
        UserDefaults.standard.clearAllAppData()
        Cache.shared.removeAll()
    }
}
