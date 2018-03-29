//
//  ChooseLoginViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 29/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

class ChooseLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true;
    }

    @IBAction func defaultLoginButtonPressed(_ sender: Any) {
        let loginController = UIStoryboard.loadViewController(from: "Auth", named: "AuthBoard") as? LoginViewController
        
        self.present(loginController!, animated: true, completion: nil)
    }

    @IBAction func registrationButtonPressed(_ sender: Any) {
         let registrationVC = UIStoryboard.loadViewController(from: "Auth", named: "RegistrationBoard") as? RegistrationViewController
        
        self.present(registrationVC!, animated: true, completion: nil)
    }
}
