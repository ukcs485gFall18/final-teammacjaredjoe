//
//  UIApplication.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/24/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// Disables user interaction for the application and shows the network activity indicator.
    public func beginWaitingForNetworkResponse() {
        DispatchQueue.main.async {
            self.isNetworkActivityIndicatorVisible = true
            self.beginIgnoringInteractionEvents()
        }
    }
    
    /// Enables user interaction for the application and hides the network activity indicator.
    public func endWaitingForNetworkResponse() {
        DispatchQueue.main.async {
            self.isNetworkActivityIndicatorVisible = false
            self.endIgnoringInteractionEvents()
        }
    }
}
