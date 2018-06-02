//
//  DetailSightViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 02/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Nuke

class DetailSightViewController: UIViewController {

    // 2 default cell = name / map
    var cachedImage:Result<UIImage>!
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
        self.infoTableView.rowHeight = UITableViewAutomaticDimension
        self.infoTableView.estimatedRowHeight = 200
        
        self.imagesCollectioView.delegate = self
        self.imagesCollectioView.dataSource = self
        
        if let count = sigthModel?.imagesURL.count, count > 1 {
            pageControl.numberOfPages = count
        } else {
            pageControl.numberOfPages = 0
        }
        
        downloadImages()
        navigationController?.isNavigationBarHidden = false
    }
}

extension DetailSightViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = map[indexPath.row + 1]
        switch key {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailNameCell", for: indexPath) as! DetailNameTableViewCell
            cell.nameSightLabel.text = sigthModel?.name
            cell.ratingLabel.text = "5.0"
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoTableViewCell
            cell.imageInfoCell.image = UIImage(named: "ruble")
            
            if let cost = sigthModel?.cost {
                cell.socialInfoLabel.text = cost
            } else {
                
                cell.socialInfoLabel.text = "Бесплатное посещение"
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoTableViewCell
            cell.imageInfoCell.image = UIImage(named: "phonenumber")
            //cell.socialInfoLabel.text = "+78318310010"
            cell.socialInfoLabel.text = sigthModel?.phoneNumber
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoTableViewCell
            cell.imageInfoCell.image = UIImage(named: "website")
            //cell.socialInfoLabel.text = "test.web-site.ru"
            cell.socialInfoLabel.text = sigthModel?.webSite
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHistoryCell", for: indexPath) as! DetailHistoryDescriptionTableViewCell
            cell.descriptionHeaderLabel.text = "Описание"
            //cell.descriptionLabel.text = "Центральная площадь – площадь Минина и Пожарского, именно на ней и расположена главная нижегородская достопримечательность - Кремль. Кстати, интересный факт: главная нижегородская площадь одновременно является и центром города и его окраиной: она расположена на высоком берегу Волги, а на другой стороне реки начинается уже другой город – Бор. От площади Минина начинается и центральная пешеходная улица – Большая Покровская."
            cell.descriptionLabel.text = sigthModel?.descript
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHistoryCell", for: indexPath) as! DetailHistoryDescriptionTableViewCell
            cell.descriptionHeaderLabel.text = "Историческая справка"
            //cell.descriptionLabel.text = "Минин и Пожарский для города Нижний Новгород личности очень значимые. Свое сегодняшнее имя центральная площадь получила в середине 20века, в момент установки мемориала К. Минину. Кроме того, народного героя увековечили в бюсте, который водружен неподалеку. До этого площадь уже успела несколько раз переименоваться, под влиянием исторических фатов и событий. Была Верхнепосадской, так как возникла в центре древнего града-посада. Затем – Благовещенской, по наименованию, возведенного в 17веке красавца храма."
            cell.descriptionLabel.text = sigthModel?.history
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailMapCell", for: indexPath) as! DetailMapTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if map[indexPath.row + 1] == 7 {
            return 250
        }
        return UITableViewAutomaticDimension
    }
}

extension DetailSightViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func downloadImages() {
        DispatchQueue.main.async {
            for img in (self.sigthModel?.imagesURL)! {
                let request = Request(url: URL(string: img)!)
                Manager.shared.loadImage(with: request, completion: { (result) in
                    self.cachedImage = result
                })
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.sigthModel?.imagesURL.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImageCell", for: indexPath) as! DetailImageCollectionViewCell
        
        let request = Request(url: URL(string: (self.sigthModel?.imagesURL[indexPath.row])!)!)
        Nuke.Manager.shared.loadImage(with: request, into: cell.sightImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imagesCollectioView.frame.width, height: imagesCollectioView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
    
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
