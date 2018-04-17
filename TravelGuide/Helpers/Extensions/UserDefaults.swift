//
//  UserDefaults.swift
//  TravelGuide
//
//  Created by Anton Makarov on 24.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private struct Store {
        static var appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }

    enum UserDefaultsKeys: String {
        case isLoggedIn
        case currentCity
        case userToken
        case userLogin
    }
    
    func createKey(_ key: String) -> String {
        return Store.appName + "-" + key
    }
    
    // Set keys
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: createKey(UserDefaultsKeys.isLoggedIn.rawValue))
        synchronize()
    }
    
    func setUserLogin(login: String) {
        set(login, forKey: createKey(UserDefaultsKeys.userLogin.rawValue))
        synchronize()
    }
    
    func setCurrentCity(cityId: NSNumber) {
        set(cityId, forKey: createKey(UserDefaultsKeys.currentCity.rawValue))
        synchronize()
    }
    
    func setUserToken(token: String) {
        set(token, forKey: createKey(UserDefaultsKeys.userToken.rawValue))
        synchronize()
    }
    
    // Chech exist keys
    func isLoggedIn() -> Bool {
        return bool(forKey: createKey(UserDefaultsKeys.isLoggedIn.rawValue))
    }
    
    func getUserLogin() -> String {
        return string(forKey: createKey(UserDefaultsKeys.userLogin.rawValue))!
    }
    
    func getCurrentCityId() -> NSNumber {
        return integer(forKey: createKey(UserDefaultsKeys.currentCity.rawValue)) as NSNumber
    }
    
    func getUserToken() -> String {
        return string(forKey: createKey(UserDefaultsKeys.userToken.rawValue))!
    }
    
    ////
    
    func clearAllAppData() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        synchronize()
    }
}
