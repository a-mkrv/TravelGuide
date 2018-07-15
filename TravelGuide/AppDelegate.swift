//
//  AppDelegate.swift
//  TravelGuide
//
//  Created by Anton Makarov on 18.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import RealmSwift
import FBSDKCoreKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        

        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(String(describing: Bundle.main.object(forInfoDictionaryKey: "CFBundleName"))).realm")
        Realm.Configuration.defaultConfiguration = config
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions:launchOptions)
        
        var initialViewController = UIViewController();
        if (isLoggedIn()) {
            _ = CurrentUser.sharedInstance
            
            if CurrentUser.sharedInstance.city?.id == nil {
                initialViewController = (StaticHelper.loadViewController(from: "Main", named: "CitiesBoard") as? CityListViewController)!
            } else {
                initialViewController = TabBarViewController()
            }
        } else {
            initialViewController = (StaticHelper.loadViewController(from: "Auth", named: "WelcomeBoard") as? WelcomeViewController)!
        }
        
        let navigationController = UINavigationController(rootViewController: initialViewController);
        navigationController.isNavigationBarHidden = true;
        self.window?.rootViewController = navigationController;
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String)
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: nil)

        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool  {
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)

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

