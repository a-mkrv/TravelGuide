//
//  UIColor.swift
//  TravelGuide
//
//  Created by Anton Makarov on 16/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let lightPink = UIColor(hex: 0xF4D6D6)
    static let lightGray = UIColor(hex: 0xEBEBF1)

    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a)
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}

