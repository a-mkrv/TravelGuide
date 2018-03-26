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
        case isFirstStart
        case userToken
    }
    
    func createKey(_ key: String) -> String {
        return Store.appName + "-" + key
    }
    
    // Set keys
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: createKey(UserDefaultsKeys.isLoggedIn.rawValue))
        synchronize()
    }
    
    func setIsFirstStart(value: Bool) {
        set(value, forKey: createKey(UserDefaultsKeys.isFirstStart.rawValue))
        synchronize()
    }
    
    func setUserToken(token: Any) {
        set(token, forKey: createKey(UserDefaultsKeys.userToken.rawValue))
        synchronize()
    }
    
    // Chech exist keys
    func isLoggedIn() -> Bool {
        return bool(forKey: createKey(UserDefaultsKeys.isLoggedIn.rawValue))
    }
    
    func isFirstStart() -> Bool {
        return bool(forKey: createKey(UserDefaultsKeys.isFirstStart.rawValue))
    }
    
    func getUserToken() -> Any {
        return createKey(UserDefaultsKeys.userToken.rawValue)
    }
}
