//
//  APIPathRepresentable.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/27/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public protocol APIModel: Codable {
    
    var id: Int { get }
    
    static var modelName: String { get }
}
