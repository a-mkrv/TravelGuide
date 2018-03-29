//
//  CityListViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 21.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cityViewModel: CityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false;
        self.cityViewModel = CityViewModel()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.setupViewModel()
    }
    
    @IBAction func confirmСityPushButton(_ sender: Any) {
        if UserDefaults.standard.getCurrentCity() == nil {
            UserDefaults.standard.setCurrentCity(city: "NN")
            let navigationVC = UINavigationController(rootViewController: TabBarViewController())
            navigationVC.modalTransitionStyle = .flipHorizontal
            self.present(navigationVC, animated: true, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                UIView.setAnimationCurve(.easeInOut)
                UIView.setAnimationTransition(.flipFromLeft, for: (self.navigationController?.view)!, cache: false)
            })
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupViewModel() {
        cityViewModel?.getAllCity(completion: {
            self.tableView.reloadData()
        })
    }
}


extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
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
