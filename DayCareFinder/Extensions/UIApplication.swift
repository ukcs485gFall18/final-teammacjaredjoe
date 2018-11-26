//
//  UIApplication.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/24/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

extension UIApplication {
    
    public func beginWaitingForNetworkResponse() {
        DispatchQueue.main.async {
            self.isNetworkActivityIndicatorVisible = true
            self.beginIgnoringInteractionEvents()
        }
    }
    
    public func endWaitingForNetworkResponse() {
        DispatchQueue.main.async {
            self.isNetworkActivityIndicatorVisible = false
            self.endIgnoringInteractionEvents()
        }
    }
}
