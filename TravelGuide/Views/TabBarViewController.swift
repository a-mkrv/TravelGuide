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
        let mainVC = storyboard.instantiateViewController(withIdentifier: "CityBoard") as? MainCityViewController

        mainVC?.tabBarItem = UITabBarItem(title: "City", image: nil, selectedImage: nil)
        sightVC?.tabBarItem = UITabBarItem(title: "Sight", image: nil, selectedImage: nil)

        let controllers = [mainVC, sightVC]
        viewControllers = controllers as? [UIViewController]
        
        // Loading all data before view
        viewControllers?.forEach { $0.view }
    }
}
