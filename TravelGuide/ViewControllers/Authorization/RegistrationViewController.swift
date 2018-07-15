//
//  RegistrationViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 25.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

enum AlertType {
    case ERROR
    case SUCCESS
    case WARNING
}

class RegistrationViewController: UIViewController, ValidityFields {
    
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
       
        guard StaticHelper.checkNetworkStatus() else {
            StaticHelper.showAlertView(title: "Упс", subTitle: "Кажется вы забыли включить интернет", buttonText: "Повторить", type: .error)
            return
        }
        
        guard let login = loginTextField.text, isLoginValid(login)  else {
            self.showAlert(title: "Упс", description: "Попробуйте в логине использовать буквы или цифры", type: .WARNING)
            return
        }
        
        guard let password = passwordTextField.text, isPasswordValid(password) else {
            self.showAlert(title: "Упс", description: "Такой пароль не подходит", type: .WARNING)
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            self.showAlert(title: "Упс", description: "Пароли не совпадают", type: .WARNING)
            return
        }
        
        let parameters: Json = ["name" : login as AnyObject, "password" : password as AnyObject]
        
        StaticHelper.showActivity(title: "Секундочку\nОбработка запроса")
        APIService.shared.createUser(with: parameters) { (response, error) in
            StaticHelper.hideActivity()
            
            guard error == nil || response != nil else {
                self.showAlert(title: "Ошибка регистрации", description: "Попробуйте еще раз", type: .ERROR)
                return
            }
            
            if response!["status"] as? String == "error" {
                self.showAlert(title: "Ошибка регистрации", description: "Такой пользователь уже существует", type: .ERROR)
                return
            }
            
            if response!["status"] as? String == "success" {
                self.showAlert(title: "Регистрация завершена", description: "Вернуться на экран авторизации", type: .SUCCESS)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismissWindow()
    }
    
    func showAlert(title: String, description: String, type: AlertType) {
        
        switch type {
        case .ERROR:
            StaticHelper.showAlertView(title: title, subTitle: description, buttonText: "Понятно", type: .error)
            
        case .SUCCESS:
            StaticHelper.showAlertView(title: title, subTitle: description, buttonText: "Понятно", type: .success) {
                self.dismissWindow()
            }
            
        case .WARNING:
            StaticHelper.showAlertView(title: title, subTitle: description, buttonText: "Понятно", type: .warning)
        }
    }
}
