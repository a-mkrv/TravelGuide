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
            StaticHelper.showAlertView(title: "Упс", subTitle: "Попробуйте в логине использовать буквы или цифры", buttonText: "Изменить логин", type: .warning)
            return
        }
        
        guard let password = passwordTextField.text, isPasswordValid(password) else {
            StaticHelper.showAlertView(title: "Упс", subTitle: "Такой пароль не подходит", buttonText: "Изменить пароль", type: .warning)
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            StaticHelper.showAlertView(title: "Упс", subTitle: "Пароли не совпадают", buttonText: "Проверить пароли", type: .warning)
            return
        }
        
        let parameters: Json = ["name" : login as AnyObject, "password" : password as AnyObject]
        
        StaticHelper.showActivity(title: "Секундочку\nОбработка запроса")
        APIService.shared.createUser(with: parameters) { (response, error) in
            StaticHelper.hideActivity()
            
            guard error == nil || response != nil else {
                StaticHelper.showAlertView(title: "Ошибка сервера", subTitle: "Сервер выключен или ведутся тех.работы. ", buttonText: "Попробовать позже", type: .warning)
                return
            }

            if response?.status == "error" {
                StaticHelper.showAlertView(title: "Ошибка регистрации", subTitle: "Такой пользователь уже существует", buttonText: "Изменить данные", type: .error)
                return
            }
            
            if response?.status == "success" {
                StaticHelper.showAlertView(title: "Регистрация завершена", subTitle: "Вернуться на экран авторизации", buttonText: "Готово", type: .success)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismissWindow()
    }
}
