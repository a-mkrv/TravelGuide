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
    
    @IBOutlet weak var pImage: UIImageView!
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pType: UILabel!

    let innerCellId = "ScrollImageCell"
    var sightId: NSNumber?
    var indexCell: Int = 0
    var imageURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pImage.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 4)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        pName.text = "None"
        pType.text = "None"
        pImage.image = UIImage(named: "sightstub")
    }
}

