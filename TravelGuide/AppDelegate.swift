//
//  AppDelegate.swift
//  TravelGuide
//
//  Created by Anton Makarov on 18.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        var initialViewController = UIViewController();
        if (isLoggedIn()) {
            initialViewController = TabBarViewController()
        } else {
            initialViewController = (UIStoryboard.loadViewController(from: "Auth", named: "WelcomeBoard") as? WelcomeViewController)!
        }
        
        let navigationController = UINavigationController(rootViewController: initialViewController);
        navigationController.isNavigationBarHidden = true;
        self.window?.rootViewController = navigationController;
        self.window?.makeKeyAndVisible()
        
        return true
    }

    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

