//
//  FilterCollectionViewCell.swift
//  TravelGuide
//
//  Created by Anton Makarov on 16/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    /// Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.layer.cornerRadius = 7.0
    }
    
    func selectCell(selectState: Bool) {
        if selectState {
            self.backView.backgroundColor = UIColor.lightPink
        } else  {
            self.backView.backgroundColor = UIColor.lightGray
        }
    }

}
