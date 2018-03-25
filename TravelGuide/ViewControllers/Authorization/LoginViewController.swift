//
//  LoginViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 24.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SCLAlertView

class LoginViewController: UIViewController, ValidityFields {

    @IBOutlet var loginTextField: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    
    @IBAction func registrationAction(_ sender: Any) {
        let registrationVC = UIStoryboard.loadViewController(from: "Auth", named: "RegistrationBoard") as? RegistrationViewController
        present(registrationVC!, animated: true, completion: {
            
        })
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let login = loginTextField.text, isLoginValid(login)  else {
            let alertView = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
            alertView.addButton("Понятно") { }
            alertView.showWarning("Упс", subTitle: "Кажется вы допустили ошибку в логине")
            return
        }
        
        guard let password = passwordTextField.text, isPasswordValid(password) else {
            let alertView = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
            alertView.addButton("Понятно") { }
            alertView.showWarning("Упс", subTitle: "Такой пароль нам не подходит")
            return
        }
        
        UserDefaults.standard.setIsLoggedIn(value: true)
        MaintNavigationController.shared.goToMainViewAfterLogin()
        UIApplication.shared.keyWindow?.switchRootViewController(MaintNavigationController.shared)
    }
}
