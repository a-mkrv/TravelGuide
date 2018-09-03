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
            
            if response?.status == "error" {
                StaticHelper.showAlertView(title: "Ошибка авторизации", subTitle: "Неправильный логин / пароль", buttonText: "Еще разок", type: .warning)
                return
            }
            
            if response?.status == "success" {
                CurrentUser.sharedInstance.token = response?.singleData.token
                CurrentUser.sharedInstance.login = login
                CurrentUser.sharedInstance.isLogin = true

                self.navigationToChooseCityView()
            }
        }
    }
    
    func navigationToChooseCityView() {
        let citiesVC = StaticHelper.loadViewController(from: "Main", named: "CitiesBoard") as? CityListViewController
        self.present(citiesVC!, animated: true, completion: nil)
    }
    
    @IBAction func cancelAfction(_ sender: Any) {
        self.dismissWindow()
    }
}
