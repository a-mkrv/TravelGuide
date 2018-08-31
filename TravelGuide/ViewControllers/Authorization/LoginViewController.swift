//
//  LoginViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 24.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController, ValidityFields {

    @IBOutlet var loginTextField: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet var signInButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    // MARK: Actions

    @IBAction func signInAction(_ sender: Any) {
        
        guard StaticHelper.checkNetworkStatus() else {
            StaticHelper.showAlertView(title: "Упс", subTitle: "Кажется вы забыли включить интернет", buttonText: "Повторить", type: .error)
            return
        }
        
        guard let login = loginTextField.text, isLoginValid(login)  else {
            StaticHelper.showAlertView(title: "Упс", subTitle: "Кажется вы допустили ошибку в логине", buttonText: "Понятно", type: .warning)
            return
        }
        
        guard let password = passwordTextField.text, isPasswordValid(password) else {
            StaticHelper.showAlertView(title: "Упс", subTitle: "Такой пароль нам не подходит", buttonText: "Понятно", type: .warning)
            return
        }
        
        let parameters: Json = ["name" : login as AnyObject, "password" : passwordTextField.text  as AnyObject]
        
        StaticHelper.showActivity(title: "Секундочку\nОбработка запроса")
        APIService.shared.doLogin(with: parameters) { (response, error) in
            StaticHelper.hideActivity()
            
            guard error == nil || response != nil else {
                StaticHelper.showAlertView(title: "Ошибка сервера", subTitle: "Сервер выключен или ведутся тех.работы. ", buttonText: "Попробовать позже", type: .warning)
                return
            }
            
            if response!["status"] as? String == "error" {
                StaticHelper.showAlertView(title: "Ошибка авторизации", subTitle: "Неправильный логин / пароль", buttonText: "Еще разок", type: .warning)
                return
            }
            
            if response!["status"] as? String == "success" {
                let token = response!["data"] as! Json
                CurrentUser.sharedInstance.token = token["token"] as? String
                CurrentUser.sharedInstance.isLogin = true
                CurrentUser.sharedInstance.login = login

                self.navigationToChooseCityView()
            }
        }
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        self.dismissWindow()
    }
    
    @IBAction func changedTextField(_ sender: SkyFloatingLabelTextField) {
        
        // 0 - Login, 1 - Password
        switch sender.tag {
        case 0:
            if let login = loginTextField.text {
                setFieldLineColor(textField: sender, isLoginValid(login))
            }
        case 1:
            if let password = passwordTextField.text {
                setFieldLineColor(textField: sender, isPasswordValid(password))
            }
        default: break
        }
    }

    // MARK: Methods

    func navigationToChooseCityView() {
        let citiesVC = StaticHelper.loadViewController(from: "Main", named: "CitiesBoard") as? CityListViewController
        self.present(citiesVC!, animated: true, completion: nil)
    }
    
}
