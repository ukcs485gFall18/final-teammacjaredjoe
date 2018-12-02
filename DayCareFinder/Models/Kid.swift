//
//  Kid.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/26/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public class Kid: APIModel {
    
    public var id: Int32?
    
    public var createdAt: String?
    
    public var updatedAt: String?
    
    public var firstName: String?
    
    public var lastName: String?
    
    public var details: String?
    
    public var age: Int?
    
    public var userId: Int?
    
    public var enrollment: Enrollment?
    
    /// Returns the first and last name as a single `String`.
    public var name: String? {
        guard let firstName = self.firstName else { return nil }
        guard let lastName = self.lastName else { return nil }
        return firstName + " " + lastName
    }
    
    /// Populates the `enrollments` property.
    ///
    /// - parameter completionHandler: A function to execute when the task is complete.
    public func getEnrollment(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        Enrollment.all {data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                let enrollments = API.decode([Enrollment].self, from: data!)
                self.enrollment = enrollments.first {$0.kidId == self.id!}
            }
            if let handler = completionHandler {
                handler(data, response, error)
            }
        }
    }
}
