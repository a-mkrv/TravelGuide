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
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var rubleImage: UIImageView!
    
    var sightId: NSNumber?
    var indexCell: Int = 0
    var imageURL: String?
    var isLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pImage.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 4)
    }

    // TODO: Link likes and places
    @IBAction func likePlace(_ sender: Any) {
        if isLiked {
            likedButton.setImage(UIImage(named: "like"), for: .normal)
            isLiked = false
        } else {
            likedButton.setImage(UIImage(named: "like-2"), for: .normal)
            isLiked = true

        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pName.text = "None"
        pType.text = "None"
        pImage.image = UIImage(named: "sightstub")
    }
}

