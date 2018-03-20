//
//  HTTPErrorCodes.swift
//  TravelGuide
//
//  Created by Anton Makarov on 20.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

public enum StatusCode: Int {
    
    case OK = 200
    case NoContent = 204
    
    case NotModified = 304
    
    case BadRequest = 400
    case UnAuthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case UnprocessableEntity = 422
    
    case InternalServerError = 500
    case NotImplemented = 501
    case BadGateway = 502
}

extension StatusCode {
    public var description: String {
        switch self {
            
        // 2xx
        case .OK:
            return "OK"
        case .NoContent:
            return "No Content"
            
        // 3xx
        case .NotModified:
            return "OK"
            
        // 4xx
        case .BadRequest:
            return "Bad Request"
        case .UnAuthorized:
            return "UnAuthorized"
        case .Forbidden:
            return "Forbidden"
        case .NotFound:
            return "Not Found"
        case .UnprocessableEntity:
            return "Unprocessable Entity"
            
        // 5xx
        case .InternalServerError:
            return "Internal Server Error"
        case .NotImplemented:
            return "Not Implemented"
        case .BadGateway:
            return "Bad Gateway"
        }
    }
}
