//
//  APIService.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import Alamofire

typealias completeRequest = (NSDictionary?, Error?) -> ()

final class APIService {
    
    static let shared = APIService()
    let endpoint = "http://188.225.82.179:5000/api_v1.0/"

    func getCities(completionHandler: @escaping completeRequest) {
        let params:Json = ["id_town" : "1" as AnyObject]
        makeRequest("get_towns", with: params, completionHandler: completionHandler)
    }
    
    func getSights(completionHandler: @escaping completeRequest) {
        let params:Json = ["id_town" : "1" as AnyObject]
        makeRequest("get_sights", with: params, completionHandler: completionHandler)
    }

    func makeRequest(_ url: String, with parameters: Json, completionHandler: @escaping completeRequest) {

        Alamofire.request(endpoint + url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
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
