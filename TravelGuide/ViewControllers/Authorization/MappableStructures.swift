//
//  MappableStructures.swift
//  TravelGuide
//
//  Created by Anton Makarov on 02/09/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import ObjectMapper

struct AuthMappable: Mappable {
    
    var token: String!
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        token <- map["token"]
    }
}
