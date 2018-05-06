//
//  Typealias.swift
//  TravelGuide
//
//  Created by Anton Makarov on 22.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation

public typealias Json = [String: AnyObject]
public typealias JsonCollection = [Json]

struct JSON<T : Codable> : Codable {
    let data: [String: T]
    let status: String
    let message: String?
}
