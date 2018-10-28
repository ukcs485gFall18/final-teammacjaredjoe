//
//  DayCare.swift
//  DayCareFinder
//
//  Created by Jared Payne on 9/2/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public struct DayCare: APIModel {
    
    public let id: Int
    
    public let name: String
    
    public static var modelName: String {
        return "day_cares"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
