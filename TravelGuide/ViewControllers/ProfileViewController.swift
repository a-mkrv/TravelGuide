//
//  SettingsViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 31/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Nuke

class ProfileViewController: UIViewController, ChangeCity {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setNewCity(id: NSNumber) {
        let vc = self.tabBarController?.viewControllers![0] as! SightViewController
        vc.setupViewModel(id)
    }
    
    @IBAction func changeCity(_ sender: Any) {
        let citiesVC = storyboard?.instantiateViewController(withIdentifier: "CitiesBoard") as? CityListViewController
        citiesVC?.delegate = self
        self.navigationController?.pushViewController(citiesVC!, animated: true)
    }
    
    
    @IBAction func signOutProfile(_ sender: Any) {
        UserDefaults.standard.clearAllAppData()
        Cache.shared.removeAll()
        
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
