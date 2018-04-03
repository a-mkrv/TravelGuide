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
    var city_id: NSNumber = 1
    var showItems = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sightViewModel = SightViewModel()
        self.sightsCollectionView.delegate = self
        self.sightsCollectionView.dataSource = self
        self.setupViewModel(city_id)
    }
    
    func setupViewModel(_ city_id: NSNumber) {
        self.city_id = city_id
        sightViewModel?.getAllSights(city_id, completion: {
            if let count = self.sightViewModel?.sights.count {
                (count > 15) ? (self.showItems = 15) : (self.showItems = count)
            }
            
            self.sightsCollectionView.reloadData()
        })
    }
    
    @IBAction func openMapAction(_ sender: Any) {
        let mapVC = UIStoryboard.loadViewController(from: "Main", named: "MapBoard") as! MapViewController
        mapVC.sightViewModel = self.sightViewModel        
        navigationController?.pushViewController(mapVC, animated: true)
    }
}


extension SightViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showItems
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if let count = self.sightViewModel?.sights.count, count > showItems {
                if (count - showItems - 10 >= 0) {
                    showItems += 10
                } else {
                    showItems += (count - showItems)
                }
                
                sightsCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (sightViewModel?.cellInstance(collectionView, cellForItemAt: indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard.loadViewController(from: "Main", named: "DetailBoard") as? DetailSightViewController
       
        if detailVC != nil {
            detailVC?.sigthModel = self.sightViewModel?.sights[indexPath.row]
            self.navigationController?.pushViewController(detailVC!, animated: true)
        }
    }

}
