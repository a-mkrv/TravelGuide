//
//  CityListViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 21.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

protocol ChangeCity {
    func setNewCity(id: NSNumber)
}

class CityListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex: Int?
    var cityViewModel: CityViewModel?
    var delegate: ChangeCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false;
        self.cityViewModel = CityViewModel()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.setupViewModel()
    }
    
    @IBAction func confirmСityPushButton(_ sender: Any) {
        guard let index = selectedIndex else {
            return
        }
        
        if UserDefaults.standard.getCurrentCity() == nil {
            let navigationVC = UINavigationController(rootViewController: TabBarViewController())
            navigationVC.modalTransitionStyle = .flipHorizontal
            self.present(navigationVC, animated: true, completion: nil)
        } else {
            delegate?.setNewCity(id: (cityViewModel?.cities[index].id)!)
            UIView.animate(withDuration: 0.5, animations: {
                UIView.setAnimationCurve(.easeInOut)
                UIView.setAnimationTransition(.flipFromLeft, for: (self.navigationController?.view)!, cache: false)
            })
            self.navigationController?.popViewController(animated: true)
        }
        
        UserDefaults.standard.setCurrentCity(city: (cityViewModel?.cities[index].name)!)
    }
    
    func setupViewModel() {
        cityViewModel?.getAllCity(completion: {
            self.tableView.reloadData()
        })
    }
}


extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row as Int
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
