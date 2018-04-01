//
//  CustomPinAnnotationView.swift
//  TravelGuide
//
//  Created by Anton Makarov on 31/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import MapKit


class CustomCalloutView: MKAnnotationView {

    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var dateLabel: UIImageView!
    @IBOutlet weak var ownerLabel: UIImageView!
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView != nil {
            self.superview?.bringSubview(toFront: hitView!)
        }
        return hitView
    }
  
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        return true
    }
    
}
