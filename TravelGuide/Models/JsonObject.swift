//
//  JsonObject.swift
//  TravelGuide
//
//  Created by Anton Makarov on 19.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

public typealias Json = [String:AnyObject]
public typealias JsonCollection = [Json]

protocol JsonObject {
    init?(json: Json?)
}

protocol JsonCollectionObject {
    static func collection(_ jsonCollection: JsonCollection) throws -> [JsonObject]
}
