//
//  UIView.swift
//  TravelGuide
//
//  Created by Anton Makarov on 14/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, borderWidth: CGFloat? = 1, borderColor: UIColor? = .clear) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask

        if let bW = borderWidth {
            self.layer.borderWidth = bW
        }
        if let bC = borderColor {
            self.layer.borderColor = bC.cgColor
        }
        
    }
    
    // Localize
    @IBInspectable open var localizedText: String? {
        set {
            let locString = newValue?.localized
            
            if (self is UIButton) {
                (self as? UIButton)?.setTitle(locString, for: .normal)
            } else if (self is UILabel) {
                (self as? UILabel)?.text = locString
            } else if (self is UITextView) {
                (self as? UITextView)?.text = locString
            } else if (self is UITextField) {
                (self as? UITextField)?.placeholder = locString
            }
        }
        get {
            return ""
        }
    }
}
