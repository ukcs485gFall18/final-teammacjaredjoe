//
//  String.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/21/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

extension String {
    
    /// Pluralizes a `String` containing a noun.
    public var pluralized: String {
        // Not a great method, but it works for our purposes.
        return self + "s"
    }
}
