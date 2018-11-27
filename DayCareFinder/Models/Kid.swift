//
//  Kid.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/26/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

public class Kid: APIModel {
    
    public var id: Int?
    
    public var createdAt: String?
    
    public var updatedAt: String?
    
    public var firstName: String?
    
    public var lastName: String?
    
    public var details: String?
    
    public var age: Int?
    
    public var userId: Int?
    
    public var name: String? {
        guard let firstName = self.firstName else { return nil }
        guard let lastName = self.lastName else { return nil }
        return firstName + " " + lastName
    }
}
