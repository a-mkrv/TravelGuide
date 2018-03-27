//
//  PlaceCollectionViewCell.swift
//  TravelGuide
//
//  Created by Anton Makarov on 19.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class SightCollectionViewCell: UICollectionViewCell {
    
    /// Outlets
    
    // Inner collection view
    @IBOutlet weak var pageImageControl: UIPageControl!
    @IBOutlet weak var imagesCollectionView: UICollectionView!

    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pType: UILabel!
    @IBOutlet weak var pDistance: UILabel!

    let innerCellId = "ScrollImageCell"
    var sightId: NSNumber?
    var pImages: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // delegate for inner cell
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        pImages = []
        pName.text = "None"
        pType.text = "None"
        pDistance.text = "0 km"
    }
}

 // MARK: Extension for UICollectionViewDataSource / UICollectionViewDelegate
extension SightCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pImages.count > 1 {
            pageImageControl.numberOfPages = pImages.count
        } else {
            pageImageControl.isHidden = true
        }
        
        return pImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: innerCellId, for: indexPath) as! InnerScrollCollectionViewCell
        cell.imageSight.image = pImages[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / imagesCollectionView.frame.width)
        pageImageControl.currentPage = pageNumber
    }
}

