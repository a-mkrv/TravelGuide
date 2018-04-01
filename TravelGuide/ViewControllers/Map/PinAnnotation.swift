//
//  AnnotationMapKit.swift
//  TravelGuide
//
//  Created by Anton Makarov on 31/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import MapKit

class PinAnnotation : NSObject, MKAnnotation {
    var title: String?
    var image: UIImageView?
    var imageURL: String?
    var coordinate: CLLocationCoordinate2D
    
    override init() {
        self.title = nil
        self.image = nil
        self.imageURL = nil
        self.coordinate = CLLocationCoordinate2D()
    }
}

class AnnotationImageView: MKAnnotationView {
    private var imageView: UIImageView!
    var imageSize = 50
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        //self.backgroundColor = .white
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize - 2, height: imageSize - 2))
        self.addSubview(self.imageView)
        
        self.layer.cornerRadius = CGFloat(imageSize / 2)
        self.layer.masksToBounds = true

        self.imageView.layer.cornerRadius = CGFloat(imageSize / 2)
        self.imageView.layer.masksToBounds = true
    }
    
    override var image: UIImage? {
        get {
            return self.imageView.image
        }
        
        set {
            self.imageView.image = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
