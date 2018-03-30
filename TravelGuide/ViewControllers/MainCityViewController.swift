//
//  MainCityViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 21.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class MainCityViewController: UIViewController, ChangeCity {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var imageCity: UIImageView!
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var metroLabel: UILabel!
    @IBOutlet weak var sightsCountLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func setNewCity(id: NSNumber) {
        let vc = self.tabBarController?.viewControllers![1] as! SightViewController
        vc.setupViewModel(id)
    }

    
    @IBAction func changeCity(_ sender: Any) {
        let citiesVC = storyboard?.instantiateViewController(withIdentifier: "CitiesBoard") as? CityListViewController
            citiesVC?.delegate = self
        self.navigationController?.pushViewController(citiesVC!, animated: true)

    }
}
