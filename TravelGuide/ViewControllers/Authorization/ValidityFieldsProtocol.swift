//
//  ValidityFieldsProtocol.swift
//  TravelGuide
//
//  Created by Anton Makarov on 25.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

protocol ValidityFields {
    
}

extension ValidityFields {
    func isPasswordValid(_ password : String) -> Bool {
        //TODO: Change regex
        let validPassword = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._]{5,}")
        return validPassword.evaluate(with: password)
    }
    
    func isLoginValid(_ login : String) -> Bool {
        let validLogin = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._]{5,}")
        return validLogin.evaluate(with: login)
    }
}
