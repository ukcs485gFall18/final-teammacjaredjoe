//
//  DayCare.swift
//  DayCareFinder
//
//  Created by Jared Payne on 9/2/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public class DayCare: APIModel {
    
    public var id: Int32?
    
    public var createdAt: String?
    
    public var updatedAt: String?
    
    public var name: String?
    
    public var address: String?
    
    public var city: String?
    
    public var state: String?
    
    public var zipCode: String?
    
    public var phoneNumber: String?
    
    public var imageUrl: String?
    
    public var userId: Int32?
    
    /// The full, formatted address of the `DayCare`.
    public var fullAddress: String? {
        guard let address = self.address else { return nil }
        guard let city = self.city else { return nil }
        guard let state = self.state else { return nil }
        guard let zipCode = self.zipCode else { return nil }
        return "\(address)\n\(city), \(state) \(zipCode)"
    }
    
    /// The formatted phone number of the `DayCare`.
    ///
    /// TODO: This currently just returns the phone number as-is.
    public var formattedPhoneNumber: String? {
        guard let phoneNumber = self.phoneNumber else { return nil }
        return phoneNumber
    }
    
    public var phoneNumberURL: URL? {
        guard let phoneNumber = self.phoneNumber else { return nil }
        let digits = String(phoneNumber.unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) } )
        return URL(string: "tel://\(digits)")!
    }
}
