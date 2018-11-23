//
//  String.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/21/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

extension String {
    
    public var pluralized: String {
        // Not a great method, but it works for our purposes.
        return self + "s"
    }
}
