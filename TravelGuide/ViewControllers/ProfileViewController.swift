//
//  SettingsViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 31/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Nuke

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func signOutProfile(_ sender: Any) {
        UserDefaults.standard.clearAllAppData()
        Cache.shared.removeAll()
        
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
