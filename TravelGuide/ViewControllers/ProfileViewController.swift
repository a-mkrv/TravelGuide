//
//  SettingsViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 31/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ChangeCity {
    
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var myNameLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCityLabel.text = CurrentUser.sharedInstance.city?.name
    }
    
    func setNewCity(city: City) {
        let vc = self.tabBarController?.viewControllers![0] as! SightViewController
        currentCityLabel.text = city.name
        vc.setupViewModel(city.id!)
    }
    
    @IBAction func changeCity(_ sender: Any) {
        let citiesVC = storyboard?.instantiateViewController(withIdentifier: "CitiesBoard") as? CityListViewController
        citiesVC?.delegate = self
        self.navigationController?.pushViewController(citiesVC!, animated: true)
    }
    
    
    @IBAction func signOutProfile(_ sender: Any) {
       
        CurrentUser.sharedInstance.logOut()
        let loginController = StaticHelper.loadViewController(from: "Auth", named: "ChooseLoginBoard") as? ChooseLoginViewController

        self.view.window!.switchRootViewController(loginController!)
    }
}
