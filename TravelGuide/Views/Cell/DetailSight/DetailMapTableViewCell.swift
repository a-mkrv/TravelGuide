//
//  DetailMapTableViewCell.swift
//  TravelGuide
//
//  Created by Anton Makarov on 03/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import MapKit

class DetailMapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var openMapButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
