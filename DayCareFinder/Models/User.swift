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
    
    public static var currentUser: User? {
        didSet {
            DispatchQueue.main.async {
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let context = delegate.persistentContainer.viewContext
                if let user = User.currentUser {
                    let credential = NSEntityDescription.insertNewObject(forEntityName: "Credential", into: context) as! Credential
                    credential.id = user.id!
                    credential.email = user.email
                    credential.authenticationToken = user.authenticationToken
                    try! context.save()
                }
                else {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Credential")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    try! context.execute(deleteRequest)
                    try! context.save()
                }
            }
        }
    }
    
    public var id: Int32?
    
    public var createdAt: String?
    
    public var updatedAt: String?
    
    public var email: String?
    
    public var password: String?
    
    public var passwordConfirmation: String?
    
    public var authenticationToken: String?
    
    public var dayCare: DayCare?
    
    public var kids: [Kid]?
    
    public static var signInURL: URL {
        return API.urlFor(User.self).appendingPathComponent("sign_in")
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
    
    public func signIn(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .post, url: User.signInURL, body: API.encode(self))
        URLSession.shared.dataTask(with: request) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 201 {
                User.currentUser = API.decode(User.self, from: data!)
            }
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    public func getDayCare(completionHandler: ((Data?, URLResponse?, Error?) -> ())?) {
        DayCare.all { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                let dayCares = API.decode([DayCare].self, from: data!)
                self.dayCare = dayCares.first { $0.userId == self.id! }
            }
            if let handler = completionHandler {
                handler(data, response, error)
            }
        }
    }
    
    public func getKids(completionHandler: ((Data?, URLResponse?, Error?) -> ())?) {
        Kid.all { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                self.kids = API.decode([Kid].self, from: data!)
            }
            if let handler = completionHandler {
                handler(data, response, error)
            }
        }
    }
}
