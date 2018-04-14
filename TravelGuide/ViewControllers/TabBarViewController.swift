//
//  TabBarViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 21.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        let sightVC = storyboard.instantiateViewController(withIdentifier: "SightBoard") as? SightViewController
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileBoard") as? ProfileViewController


        sightVC?.tabBarItem = UITabBarItem(title: "Места", image: UIImage(named: "tabBar02"), selectedImage: nil)
        profileVC?.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "tabBar04"), selectedImage: nil)

        let controllers = [sightVC, profileVC]
        viewControllers = controllers as? [UIViewController]
        
        // Loading all data before view
        for viewController in self.viewControllers! {
            let _ = viewController.view
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
    }
    
    deinit {
        Logger.info(msg: "Deinit")
    }
}
