//
//  MaintNavigationController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 24.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class MaintNavigationController: UINavigationController {

    static let shared = MaintNavigationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            let homeController = TabBarViewController()
            viewControllers = [homeController]
        }
        else if isFirstStart() {
            let loginController = UIStoryboard.loadViewController(from: "Auth", named: "AuthBoard") as? LoginViewController
            viewControllers = [loginController!]
        }
        else {
            perform(#selector(showWelcomeScreen), with: nil, afterDelay: 0.05)
        }
    }
    
    fileprivate func isFirstStart() -> Bool {
        return UserDefaults.standard.isFirstStart()
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc fileprivate func showWelcomeScreen() {
        let welcomeVC = UIStoryboard.loadViewController(from: "Auth", named: "WelcomeBoard") as? WelcomeViewController
        present(welcomeVC!, animated: true, completion: {
            
        })
    }
    
    func goToMainViewAfterLogin() {
        let homeController = TabBarViewController()
        viewControllers.removeAll()
        viewControllers = [homeController]
    }
    
    deinit {
        print("MaintNavigationController - deinit")
    }
}
