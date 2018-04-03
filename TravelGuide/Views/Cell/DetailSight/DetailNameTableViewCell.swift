//
//  DetailNameTableViewCell.swift
//  TravelGuide
//
//  Created by Anton Makarov on 03/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class DetailNameTableViewCell: UITableViewCell {

    @IBOutlet weak var iconNameCell: UIImageView!
    @IBOutlet weak var nameSightLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
