//
//  SightViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class SightViewController: UIViewController {
    
    @IBOutlet weak var sightsCollectionView: UICollectionView!
    
    var sightViewModel: SightViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sightViewModel = SightViewModel()
        self.sightsCollectionView.delegate = self
        self.sightsCollectionView.dataSource = self
        
        self.setupViewModel()
    }
    
    
    func setupViewModel() {
        sightViewModel?.getAllSights(completion: {
            self.sightsCollectionView.reloadData()
        })
    }
    
}


extension SightViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = sightViewModel?.sights.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (sightViewModel?.cellInstance(collectionView, cellForItemAt: indexPath))!
    }
}
