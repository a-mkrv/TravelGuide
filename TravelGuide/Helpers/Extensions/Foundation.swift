//
//  Foundation.swift
//  TravelGuide
//
//  Created by Anton Makarov on 28/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

// Date
extension Foundation.Date {
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd/HH:mm:ss.SSS"
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    var localized: String {
        
        let local = StaticHelper.getCurrentLanguage()
        let path = Bundle.main.path(forResource: local, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
