//
//  APIService.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import Alamofire

final class APIService {
    
    static let shared = APIService()
    
    let endpoint = "http://188.225.82.179:5000/api_v1.0/get_sights"
    
    func getOrders(completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        makeCall("orders", completionHandler: completionHandler)
    }
    
    func makeCall(_ section: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let params = ["id_town":"1"]

        Alamofire.request(endpoint, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
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
