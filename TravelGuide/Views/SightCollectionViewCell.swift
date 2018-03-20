//
//  PlaceCollectionViewCell.swift
//  TravelGuide
//
//  Created by Anton Makarov on 19.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class SightCollectionViewCell: UICollectionViewCell {
    
    /// Outlets

    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pType: UILabel!
    @IBOutlet weak var pDistance: UILabel!
    @IBOutlet weak var pImage: UIImageView!

    var sightId: String?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pImage.image = nil
        pName.text = "None"
        pType.text = "None"
        pDistance.text = "0 km"
    }
}
