//
//  DetailSightViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 02/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class DetailSightViewController: UIViewController {

    // 2 default cell = name / map
    var rowCount = 1
    var map = [Int:Int]()
    var sigthModel: Sight? = nil {
        didSet {
            map[1] = 1
            if sigthModel?.cost != nil {
                rowCount += 1
                map[rowCount] = 2
            }
            if sigthModel?.descript != nil {
                rowCount += 1
                map[rowCount] = 3
            }
            if sigthModel?.history != nil {
                rowCount += 1
                map[rowCount] = 4
            }
            if sigthModel?.phoneNumber != nil {
                rowCount += 1
                map[rowCount] = 5
            }
            if sigthModel?.webSite != nil {
                rowCount += 1
                map[rowCount] = 6
            }
            rowCount += 1
            map[rowCount] = 7
        }
    }
   
    
    @IBOutlet weak var imagesCollectioView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var infoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoTableView.delegate = self
        self.infoTableView.dataSource = self
        
        navigationController?.isNavigationBarHidden = false
    }
}

extension DetailSightViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var key = map[indexPath.row + 1]
        switch key {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailNameCell", for: indexPath) as! DetailNameTableViewCell
            cell.nameSightLabel.text = "testName"
            cell.ratingLabel.text = "5"
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoTableViewCell
            cell.socialInfoLabel.text = String(format: "%f", (sigthModel?.cost)!)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoTableViewCell
            cell.socialInfoLabel.text = sigthModel?.phoneNumber
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoTableViewCell
            cell.socialInfoLabel.text = sigthModel?.webSite
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHistoryCell", for: indexPath) as! DetailHistoryDescriptionTableViewCell
            cell.descriptionHeaderLabel.text = "Описание"
            cell.descriptionLabel.text = sigthModel?.descript
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHistoryCell", for: indexPath) as! DetailHistoryDescriptionTableViewCell
            cell.descriptionHeaderLabel.text = "Историческая справка"
            cell.descriptionLabel.text = sigthModel?.history
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailMapCell", for: indexPath) as! DetailMapTableViewCell
            return cell
        }
    }
}

extension DetailSightViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImageCell", for: indexPath) as! DetailImageCollectionViewCell
        return cell
    }
    

}
