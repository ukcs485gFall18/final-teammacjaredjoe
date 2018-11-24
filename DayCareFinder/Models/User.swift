//
//  User.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/19/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import CoreData
import UIKit

public class User: APIModel {
    
    public private(set) static var currentUser: User? {
        didSet {
            guard let user = currentUser else { return }
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let credential = NSEntityDescription.insertNewObject(forEntityName: "Credential", into: context) as! Credential
            credential.email = user.email
            credential.authenticationToken = user.authenticationToken
        }
    }
    
    public var id: Int?
    
    public var createdAt: String?
    
    public var updatedAt: String?
    
    public var email: String?
    
    public var password: String?
    
    public var passwordConfirmation: String?
    
    public var authenticationToken: String?
    
    public static var sessionURL: URL {
        return API.urlFor(User.self).appendingPathComponent("sign_in")
    }
    
    public func signIn(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .post, url: User.sessionURL, body: API.encode(self))
        URLSession.shared.dataTask(with: request) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 201 {
                User.currentUser = API.decode(User.self, from: data!)
            }
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    public func signUp(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        self.post { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 201 {
                User.currentUser = API.decode(User.self, from: data!)
            }
            if let handler = completionHandler {
                handler(data, response, error)
            }
        }
    }
}
