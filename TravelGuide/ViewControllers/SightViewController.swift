//
//  SightViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Nuke

class SightViewController: UIViewController, ChangeSightCategory {
    
    @IBOutlet weak var mapFilterView: UIView!
    @IBOutlet weak var foggingHeaderView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var downloadView: UIView!
    
    @IBOutlet weak var sightsCollectionView: UICollectionView!
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var changeFilterButton: UIButton!
    @IBOutlet weak var openMapButton: UIButton!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    var sightViewModel: SightViewModel?
    var weatherViewModel: WeatherViewModel?
    var city_id: NSNumber!
    var showItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sightViewModel = SightViewModel()
        self.weatherViewModel = WeatherViewModel()
        
        self.sightsCollectionView.delegate = self
        self.sightsCollectionView.dataSource = self
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.sightsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.city_id = CurrentUser.sharedInstance.city?.id
        self.setupViewModel(city_id)
    }
    
    func updateSightsCollectionView() {
        let selectedCategories = CurrentUser.sharedInstance.favoriteCategories.map({ String($0.prefix(4)) })
        
        // FIXME: Fix this mego crutch
        if selectedCategories.count == 1 && selectedCategories[0] == "Выбр" {
            sightViewModel?.diplaySights = (sightViewModel?.sights)!
        } else {
            let isDisplaySights = sightViewModel?.sights.filter( {selectedCategories.contains(String($0.type.prefix(4)))} )
            sightViewModel?.diplaySights = isDisplaySights!
        }
        
        if let count = sightViewModel?.diplaySights.count {
            (count > 15) ? (showItems = 15) : (showItems = count)
        }
        
        self.sightsCollectionView.reloadData()
    }
    
    func sortedSights(by: SortSights) {
        switch by {
        case .rating:
            _ = sightViewModel?.sights.sorted(by: { $0.rating > $1.rating } )
        case .price:
            _ = sightViewModel?.sights.sorted(by: { $0.cost > $1.cost } )
        case .comments:
            break
        case .distanceFromMe:
            break
        }
    }
    
    func setupView() {
        self.cityNameLabel.text = CurrentUser.sharedInstance.city?.name
        manager.loadImage(with: Request(url: URL(string: (CurrentUser.sharedInstance.city?.urlImage)!)!), into: cityImage)
        
        if (CurrentUser.sharedInstance.city?.isDownload)! {
            self.downloadButton.setImage(UIImage(named: "cloud-ok"), for: .normal)
        } else {
            self.downloadButton.setImage(UIImage(named: "cloud-no"), for: .normal)
        }
        
        self.downloadView.layer.cornerRadius = downloadView.frame.width / 2
        self.mapFilterView.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 5, borderWidth: 1, borderColor: .darkGray)
    }
    
    @IBAction func downloadCity(_ sender: Any) {
        if !(CurrentUser.sharedInstance.city?.isDownload)! {
            self.downloadButton.setImage(UIImage(named: "cloud-ok"), for: .normal)
            self.sightViewModel?.populateRealmSights()
            CurrentUser.sharedInstance.city?.isDownload = true
        }
    }
    
    func setupViewModel(_ city_id: NSNumber) {
        DispatchQueue.main.async {
            self.weatherViewModel?.getWeatherOfCity(name: "Moscow", period: .Day)
        }
        
        self.city_id = city_id
        sightViewModel?.getAllSights(city_id, completion: {
            self.updateSightsCollectionView()
            self.setupView()
        })
    }
    
    @IBAction func openMapAction(_ sender: Any) {
        let mapVC = StaticHelper.loadViewController(from: "Main", named: "MapBoard") as! MapViewController
        mapVC.sightViewModel = self.sightViewModel        
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushFilter" {
            if let destination = segue.destination as? FilterViewController {
                destination.delegate = self
            }
        }
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
            if let count = self.sightViewModel?.diplaySights.count, count > showItems {
                if (count - showItems - 10 >= 0) {
                    showItems += 10
                } else {
                    showItems += (count - showItems)
                }
                
                sightsCollectionView.reloadData()
            }
        }
        
        
        return
        if (self.sightsCollectionView.frame.origin.y < foggingHeaderView.frame.height + openMapButton.frame.height) {
            self.headerTopConstraint.constant = -100
            return
        }
        
        self.headerTopConstraint.constant -= offsetY / 100
        //
        //        if (scrollView.contentOffset.y < 50) {
        //            if (self.sightsCollectionView.frame.origin.y >= headerView.frame.height) {
        //                // self.headerTopConstraint.constant = 380
        //                return
        //            }
        //
        //            self.headerHeightConstraint.constant += 5
        //
        //            //            self.headerTopConstraint.constant += scrollView.contentOffset.y / 100
        //            return
        //        }
        //
        //        if (self.sightsCollectionView.frame.origin.y < foggingHeaderView.frame.height + openMapButton.frame.height) {
        //            return
        //        }
        //
        //        self.headerTopConstraint.constant -= scrollView.contentOffset.y / 100
        //        return
        //
        //        let n = foggingHeaderView.frame.height + openMapButton.frame.height
        //        if scrollView.contentOffset.y < 0 {
        //            self.headerHeightConstraint.constant += 5
        //            self.incrementColorAlpha(offset: self.headerHeightConstraint.constant)
        //            self.incrementArticleAlpha(offset: self.headerHeightConstraint.constant)
        //        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= n {
        //            self.headerHeightConstraint.constant -= scrollView.contentOffset.y / 100
        //            self.decrementColorAlpha(offset: scrollView.contentOffset.y)
        //            self.decrementArticleAlpha(offset: self.headerHeightConstraint.constant)
        //
        //            if self.headerHeightConstraint.constant < n {
        //                self.headerHeightConstraint.constant = n
        //            }
        //        }
    }
    
    func animateHeader() {
        self.headerHeightConstraint.constant = 380
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func decrementColorAlpha(offset: CGFloat) {
        if self.cityImage.alpha <= 1 {
            let alphaOffset = (offset/500)/85
            self.cityImage.alpha += alphaOffset
        }
    }
    
    func decrementArticleAlpha(offset: CGFloat) {
        if self.openMapButton.alpha >= 0 {
            let alphaOffset = max((offset - foggingHeaderView.frame.height + openMapButton.frame.height)/85.0, 0)
            self.openMapButton.alpha = alphaOffset
            self.changeFilterButton.alpha = alphaOffset
        }
    }
    func incrementColorAlpha(offset: CGFloat) {
        if self.cityImage.alpha >= 0.6 {
            let alphaOffset = (offset/200)/85
            self.cityImage.alpha -= alphaOffset
        }
    }
    func incrementArticleAlpha(offset: CGFloat) {
        if self.openMapButton.alpha <= 1 {
            let alphaOffset = max((offset - foggingHeaderView.frame.height + openMapButton.frame.height)/85, 0)
            self.openMapButton.alpha = alphaOffset
            self.changeFilterButton.alpha = alphaOffset
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant >= 380 {
            self.headerHeightConstraint.constant = 380
            //animateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant >= 380 {
            self.headerHeightConstraint.constant = 380
            //animateHeader()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (sightViewModel?.cellInstance(collectionView, cellForItemAt: indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = StaticHelper.loadViewController(from: "Main", named: "DetailBoard") as? DetailSightViewController
        
        if detailVC != nil {
            detailVC?.sigthModel = self.sightViewModel?.diplaySights[indexPath.row]
            self.navigationController?.pushViewController(detailVC!, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView:UICollectionReusableView?
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView:HeaderSightsCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderSightView", for: indexPath) as! HeaderSightsCollectionReusableView
            reusableView =  headerView
            
        }
        
        return reusableView!
    }
    
}
