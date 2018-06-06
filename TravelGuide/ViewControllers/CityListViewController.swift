//
//  CityListViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 21.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

protocol ChangeCity {
    func setNewCity(city: City)
}

class CityListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex: Int?
    var cityViewModel: CityViewModel?
    var delegate: ChangeCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true;
        
        self.cityViewModel = CityViewModel()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.setGradientBackground()
        self.setupViewModel()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 130.0/255.0, green: 126.0/255.0, blue: 163.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 226.0/255.0, green: 232.0/255.0, blue: 246.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundColor = .clear
    }
    
    func setupViewModel() {
        cityViewModel?.getAllCity(completion: {
            self.tableView.reloadData()
        })
    }
}


extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = (cityViewModel?.cities[indexPath.row])!
        
        if CurrentUser.sharedInstance.city == nil {
            CurrentUser.sharedInstance.city = city
            let navigationVC = UINavigationController(rootViewController: TabBarViewController())
            navigationVC.modalTransitionStyle = .flipHorizontal
            self.view.window?.switchRootViewController(navigationVC)
        } else {
            delegate?.setNewCity(city: city)
            UIView.animate(withDuration: 0.5, animations: {
                UIView.setAnimationCurve(.easeInOut)
                UIView.setAnimationTransition(.flipFromLeft, for: (self.navigationController?.view)!, cache: false)
            })
            
            CurrentUser.sharedInstance.city = city
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = cityViewModel?.cities.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (cityViewModel?.cellInstance(tableView, cellForItemAt: indexPath))!
    }
}
