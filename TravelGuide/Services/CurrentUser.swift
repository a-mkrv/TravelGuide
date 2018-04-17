//
//  ObjectManager.swift
//  TravelGuide
//
//  Created by Anton Makarov on 17/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

class CurrentUser {
    
    static let sharedInstance = CurrentUser()
    
    var login: String?
    var country: NSNumber?
    var city: NSNumber?
    var categories: [String] = []
    var isLogin: Bool = false
    
    private init() {
        self.isLogin = UserDefaults.standard.isLoggedIn()
        self.city = UserDefaults.standard.getCurrentCityId()
        self.country = 1
    }

    
    func logIn(login: String) {
        self.login = login
    }
    
    func setCurrentCity(country: NSNumber, city: NSNumber) {
        self.country = country
        self.city = country
    }
}
