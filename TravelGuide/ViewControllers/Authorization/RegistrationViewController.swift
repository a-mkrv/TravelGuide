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
    
    @IBAction func changedTextField(_ sender: SkyFloatingLabelTextField) {
        
        // 0 - Login, 1 - Password, 2 - Confirm Password
        switch sender.tag {
        case 0:
            if let login = loginTextField.text {
                setFieldLineColor(textField: sender, isLoginValid(login))
            }
        case 1, 2:
            if let passwordField = passwordTextField, let password = passwordField.text, let confirm = confirmPasswordTextField {
                setFieldLineColor(textField: passwordField, isPasswordValid(password))
                setFieldLineColor(textField: confirm, (password == confirm.text && !(confirm.text?.isEmpty)!))
            }
            
        default: break
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
