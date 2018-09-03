//
//  APIService.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum TypeRequest {
    case external
    case inner
}

typealias completeRequest<T> = (_ object: T?, Error?) -> ()

final class APIService {
    
    static let shared = APIService()
    private var AlamofireManager = Alamofire.SessionManager(configuration: .default)
    private let endpoint = "https://travel.truegrom.me/api_v1.0/"

    init() {
        changeConfiguration()
    }
    
    func changeConfiguration(timeoutInterval: Double = 15) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutInterval // seconds
        self.AlamofireManager = Alamofire.SessionManager(configuration: configuration)
    }

    // Custom public methods
    func getCities(completionHandler: @escaping completeRequest<BaseResponseItem<City>>) {
        // 1 - id country, while always 1 - Russia
        let parameters: Json = ["id_town" : "1" as AnyObject]
//        let apiResponse = Mapper<T>().mapArray(JSONObject: response.result.value)
    
        makeRequest("get_towns", with: parameters, completionHandler: completionHandler)
    }
    
    func getSights(_ city_id: NSNumber, completionHandler: @escaping completeRequest<BaseResponseItem<AuthMappable>>) {
        let parameters: Json = ["id_town" : city_id as AnyObject]
        makeRequest("get_sights", with: parameters, completionHandler: completionHandler)
    }

    func createUser(with parameters: Json, completionHandler: @escaping completeRequest<BaseResponseItem<AuthMappable>>) {
        makeRequest("create_user", with: parameters, completionHandler: completionHandler)
    }
    
    func doLogin(with parameters: Json, completionHandler: @escaping completeRequest<BaseResponseItem<AuthMappable>>) {
        makeRequest("login", with: parameters, completionHandler: completionHandler)
    }
    
    func getWeather<T: Mappable>(url: String, parameters: Json, completionHandler: @escaping completeRequest<T>) {
        makeRequest(request: .external, url, with: parameters, completionHandler: completionHandler)
    }
    
    // Internal request to perform
    private func makeRequest<T: BaseMappable>(request: TypeRequest = .inner, _ url: String, with parameters: Json, httpMethod: HTTPMethod = .get, completionHandler: @escaping (T?, Error?) -> Void) {

        var urlRequest: String = ""
        switch request {
        case .external:
            urlRequest = url
        case .inner:
            urlRequest = endpoint + url
        }
        
        AlamofireManager.request(urlRequest, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<T>) in
                
                switch response.result {
                case .success(let value):
                    completionHandler(value, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
            })
    }
}


// MARK: BaseResponseItem
struct BaseResponseItem<T: BaseMappable>: Mappable {
    
    var singleData: T!
    var arrayData: [String : T]?
    var message: String!
    var status: String!
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        singleData <- map["data"]
        arrayData <- map["data"]
        message <- map["message"]
        status <- map["status"]
    }
}
