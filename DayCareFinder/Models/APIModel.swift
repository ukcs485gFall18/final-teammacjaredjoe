//
//  APIModel.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/27/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public protocol APIModel: Codable {
    
    var id: Int32? { get set }
    
    var createdAt: String? { get set }
    
    var updatedAt: String? { get set }
}

extension APIModel {
    
    /// Fetches all of the entries of a model class from the database.
    ///
    /// - parameter completionHandler: A function to execute when the task is complete.
    public static func all(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .get, url: API.urlFor(self), body: nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    /// Fetches the properties of a model entry given its set ID.
    ///
    /// - parameter completionHandler: A function to execute when the task is complete.
    public func get(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .get, url: API.urlFor(self), body: nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    /// Posts a model entry to the database.
    ///
    /// - parameter completionHandler: A function to execute when the task is complete.
    public func post(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .post, url: API.urlFor(type(of: self)), body: API.encode(self))
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    /// Updates a model entry already in the database.
    ///
    /// - parameter completionHandler: A function to execute when the task is complete.
    public func patch(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .patch, url: API.urlFor(self), body: API.encode(self))
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    /// Deletes a model entry from the database.
    ///
    /// - parameter completionHandler: A function to execute when the task is complete.
    public func delete(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .delete, url: API.urlFor(self), body: nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
}
