//
//  APIService.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import Alamofire

enum TypeRequest {
    case external
    case inner
}

typealias completeRequest = (NSDictionary?, Error?) -> ()

final class APIService {
    
    static let shared = APIService()
    private var AlamofireManager = Alamofire.SessionManager(configuration: .default)
    private let endpoint = "http://82.146.44.98:5000/api_v1.0/"

    init() {
        changeConfiguration()
    }
    
    func changeConfiguration(timeoutInterval: Double = 15) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutInterval // seconds
        self.AlamofireManager = Alamofire.SessionManager(configuration: configuration)
    }

    // Custom public methods
    func getCities(completionHandler: @escaping completeRequest) {
        // 1 - id country, while always 1 - Russia
        let parameters: Json = ["id_town" : "1" as AnyObject]
        makeRequest("get_towns", with: parameters, completionHandler: completionHandler)
    }
    
    func getSights(_ city_id: NSNumber, completionHandler: @escaping completeRequest) {
        let parameters: Json = ["id_town" : city_id as AnyObject]
        makeRequest("get_sights", with: parameters, completionHandler: completionHandler)
    }

    func createUser(with parameters: Json, completionHandler: @escaping completeRequest) {
        makeRequest("create_user", with: parameters, completionHandler: completionHandler)
    }
    
    func doLogin(with parameters: Json, completionHandler: @escaping completeRequest) {
        makeRequest("login", with: parameters, completionHandler: completionHandler)
    }
    
    func getWeather(url: String, parameters: Json, completionHandler: @escaping completeRequest) {
        makeRequest(request: .external, url, with: parameters, completionHandler: completionHandler)
    }
    
    // Internal request to perform
    private func makeRequest(request: TypeRequest = .inner, _ url: String, with parameters: Json, httpMethod: HTTPMethod = .get, completionHandler: @escaping completeRequest) {

        var urlRequest: String = ""
        switch request {
        case .external:
            urlRequest = url
        case .inner:
            urlRequest = endpoint + url
        }
        
        AlamofireManager.request(urlRequest, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
}
