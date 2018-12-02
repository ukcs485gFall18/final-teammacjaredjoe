//
//  Enrollment.swift
//  DayCareFinder
//
//  Created by Mac's Book on 12/1/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public class Enrollment: APIModel {
    
    public var id: Int32?
    
    public var createdAt: String?
    
    public var updatedAt: String?
    
    public var kidId: Int32?
    
    public var dayCareId: Int32?
    
    public var dayCare: DayCare?
    
    public func getDayCare(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        DayCare.all {data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                let dayCares = API.decode([DayCare].self, from: data!)
                self.dayCare = dayCares.last {$0.id == self.dayCareId}
            }
            if let handler = completionHandler {
                handler(data, response, error)
            }
        }
    }
    
}
