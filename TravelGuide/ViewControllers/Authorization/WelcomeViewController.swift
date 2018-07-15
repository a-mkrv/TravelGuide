//
//  WelcomeViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 22.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

struct Page {
    let title: String
    let description: String
    let imageName: String
}

class WelcomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var startButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControlBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var skipTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextTopConstraint: NSLayoutConstraint!
    
    let cellID = "WelcomeCell"
    let pages: [Page] = {
        let page_1 = Page(title: "First page", description: "First page", imageName: "nn")
        let page_2 = Page(title: "Second page", description: "Second page", imageName: "nn")
        let page_3 = Page(title: "Third page", description: "Third page", imageName: "nn")
        let page_4 = Page(title: "Fourth page", description: "Fourth page", imageName: "nn")
        return [page_1, page_2, page_3, page_4]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButtonConstraint.constant = -50
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func skipPages(_ sender: Any) {
        pageControl.currentPage = pages.count - 2
        nextPage(sender)
    }
    
    @IBAction func nextPage(_ sender: Any) {
        if pageControl.currentPage == pages.count - 1 {
            return
        }
        
        if pageControl.currentPage == pages.count - 2 {
            moveControlConstraintsOffScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    @IBAction func presentLoginScreen(_ sender: Any) {
        let loginController = StaticHelper.loadViewController(from: "Auth", named: "ChooseLoginBoard") as? ChooseLoginViewController
        self.navigationController?.pushViewController(loginController!, animated: true);
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        startButtonConstraint?.constant = 60
        pageControlBottomConstraint?.constant = -30
        skipTopConstraint?.constant = -(skipButton.frame.height * 2)
        nextTopConstraint?.constant = -(nextButton.frame.height * 2)
    }
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WelcomeCollectionViewCell
        
        let page = pages[indexPath.row]
        cell.imageCell.image = UIImage(named: page.imageName)
        cell.titleLabel.text = page.title
        cell.descriptionLabel.text = page.description
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pages.count - 1 {
            moveControlConstraintsOffScreen()
        } else {
            pageControlBottomConstraint?.constant = 30
            skipTopConstraint?.constant = 10
            nextTopConstraint?.constant = 10
            startButtonConstraint?.constant = -50
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
