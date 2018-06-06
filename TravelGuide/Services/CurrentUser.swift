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
    private init() {}

    var login: String? {
        get { return UserDefaults.standard.getUserLogin() }
        set { UserDefaults.standard.setUserLogin(login: newValue!) }
    }

    var isLogin: Bool {
        get { return UserDefaults.standard.isLoggedIn() }
        set { UserDefaults.standard.setIsLoggedIn(value: newValue) }
    }
    
    var token: String? {
        get { return UserDefaults.standard.getUserToken() }
        set { UserDefaults.standard.setUserToken(token: newValue!) }
    }
    
    var favoriteCategories: [String] {
        get { return UserDefaults.standard.getFavoriteCategories() }
        set { UserDefaults.standard.setFavoriteCategories(categories: newValue) }
    }
    
    var city: City? {
        get {
            if let properties = UserDefaults.standard.getCurrentCity() {
                return City(dictionary: properties)
            }
            return nil
        }
        set { UserDefaults.standard.setCurrentCity(cityProperties: (newValue?.propertyList)!) }
    }
    
    func logOut() {
        favoriteCategories = ["Выбрать все"]
        UserDefaults.standard.clearAllAppData()
        Cache.shared.removeAll()
    }
}
