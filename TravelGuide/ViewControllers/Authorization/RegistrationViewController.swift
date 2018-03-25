//
//  RegistrationViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 25.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SCLAlertView

enum AlertType {
    case ERROR
    case SUCCESS
    case WARNING
}

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    // TextEdit Handler
    
    @IBAction func loginEnter(_ sender: Any) {
        if loginTextField.text?.count == 0 {
            loginTextField.errorMessage = ""
            return
        }
        
        if let textField = loginTextField  {
            if !isLoginValid(textField.text!) {
                textField.errorMessage = "Invalid login"
            }
            else {
                textField.errorMessage = ""
            }
        }
    }
    
    @IBAction func passwordEnter(_ sender: Any) {
        if passwordTextField.text?.count == 0 {
            passwordTextField.errorMessage = ""
            return
        }
        
        if let textField = passwordTextField  {
            if !isLoginValid(textField.text!) {
                textField.errorMessage = "Invalid password"
            }
            else {
                textField.errorMessage = ""
            }
        }
    }
    
    @IBAction func confirmPasswordEnter(_ sender: Any) {
        if confirmPasswordTextField.text?.count == 0 {
            confirmPasswordTextField.errorMessage = ""
            return
        }
        
        if let password = passwordTextField, let confirm = confirmPasswordTextField  {
            if password.text != confirm.text {
                confirm.errorMessage = "Don't match"
            }
            else {
                confirm.errorMessage = ""
            }
        }
    }
    
    // Button Handler

    @IBAction func registerAction(_ sender: Any) {
        guard let login = loginTextField.text, isLoginValid(login)  else {
            self.showAlert(title: "Упс", description: "Попробуйте в логине использовать буквы или цифры", type: .WARNING)
            return
        }
        
        guard let password = passwordTextField.text, isPasswordValid(password) else {
            self.showAlert(title: "Упс", description: "Такой пароль нам не подходит", type: .WARNING)
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            self.showAlert(title: "Упс", description: "Пароли не совпадают", type: .WARNING)
            return
        }
        
        let parameters: Json = ["name" : login as AnyObject, "password" : password as AnyObject]
        
        APIService.shared.createUser(with: parameters) { (nil, error) in
            if error == nil {
                self.showAlert(title: "Регистрация завершена", description: "Вернуться на экран авторизации", type: .SUCCESS)
            } else {
                self.showAlert(title: "Ошибка регистрации", description: "Попробуйте еще раз", type: .SUCCESS)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        customDismissView()
    }
    
    func showAlert(title: String, description: String, type: AlertType) {
        
        let alertView = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
        
        switch type {
        case .ERROR:
            alertView.showError("Registration error", subTitle: "Try again")
            
        case .SUCCESS:
            alertView.addButton("Понятно") {
                self.customDismissView()
            }
            alertView.showSuccess(title, subTitle: description)
            
        case .WARNING:
            alertView.addButton("Понятно") { }
            alertView.showWarning(title, subTitle: description)
        }
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let validPassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{5,}")
        return validPassword.evaluate(with: password)
    }
    
    func isLoginValid(_ login : String) -> Bool {
        let validLogin = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._]{5,}")
        return validLogin.evaluate(with: login)
    }
    
    func customDismissView() {
        let transition: CATransition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
