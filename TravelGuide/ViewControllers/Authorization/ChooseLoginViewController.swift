//
//  ChooseLoginViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 29/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class ChooseLoginViewController: UIViewController {

    @IBOutlet weak var withoutNetworkFeatureView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.withoutNetworkFeatureView.isHidden = (DBManager.sharedInstance.databaseIsEmpty() && CurrentUser.sharedInstance.allSavedCities.isEmpty)
        UIApplication.shared.isStatusBarHidden = true;
    }
    
    @IBAction func facebookAuthorization(_ sender: Any) {
        SocialLoginManager.sharedInstance.facebookLogInWithReadPermissions(fromViewController: self, handler: { (result) in
            print("Facebook result SUCCESS: ", result)
        }) { (error) in
            print("Facebook ERROR", error.localizedDescription)
        }
    }
    
    @IBAction func vkAuthorization(_ sender: Any) {
        SocialLoginManager.sharedInstance.vkontakteLogInWithReadPermissions(fromViewController: self, handler: { (token) -> Void in
                print("VK result SUCCESS:", token!.accessToken)
        })
        { (error) -> Void in
            print("VK ERROR", error!.localizedDescription)
        }
    }
    
    @IBAction func defaultPasswordAuthorization(_ sender: Any) {
        let loginController = StaticHelper.loadViewController(from: "Auth", named: "AuthBoard") as? LoginViewController
        
        self.present(loginController!, animated: true, completion: nil)
    }

    @IBAction func registrationButtonPressed(_ sender: Any) {
         let registrationVC = StaticHelper.loadViewController(from: "Auth", named: "RegistrationBoard") as? RegistrationViewController
        
        self.present(registrationVC!, animated: true, completion: nil)
    }
    
    @IBAction func loginWithoutNetwork(_ sender: Any) {
        let citiesVC = StaticHelper.loadViewController(from: "Main", named: "CitiesBoard") as? CityListViewController
        citiesVC?.openWithoutNetwork = true
        self.present(citiesVC!, animated: true, completion: nil)
    }
    
    @IBAction func openFeatureDescription(_ sender: Any) {
    }
}
