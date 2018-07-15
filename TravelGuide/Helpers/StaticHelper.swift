//
//  StaticHelper.swift
//  TravelGuide
//
//  Created by Anton Makarov on 15/07/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class StaticHelper: NSObject {
    
    static let networkStateManager = NetworkReachabilityManager()
    static var animationTimer: Timer?

    static func loadViewController(from storyboard: String, named name: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name)
    }
    
    static func showActivity(title: String, type: NVActivityIndicatorType = .ballTrianglePath) {
        
        guard !NVActivityIndicatorPresenter.sharedInstance.isAnimating else {
            return
        }
        
        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(checkActivity), userInfo: nil, repeats: false)

        let sizeValue = (40.0 / 375.0) * UIScreen.main.bounds.size.width
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size:  CGSize(width: sizeValue, height: sizeValue), message: title, messageFont: UIFont.systemFont(ofSize: 16.0), type: type, color: .white, padding: 0.0, displayTimeThreshold: 0, minimumDisplayTime: 0))
    }
    
    static func hideActivity(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        animationTimer?.invalidate()
    }
    
    @objc static func checkActivity() {
        if NVActivityIndicatorPresenter.sharedInstance.isAnimating {
            changeTitleActivity(message: "Запрос выполняется дольше обычного\nТерпения, еще чуть-чуть")
        }
    }
    
    static func changeTitleActivity(message: String) {
       NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
    }
    
    //MARK: Check Internet Connection
    static func checkNetworkStatus() -> Bool {
        return (StaticHelper.networkStateManager?.isReachable)!
    }
}
