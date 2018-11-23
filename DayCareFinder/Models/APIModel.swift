//
//  APIModel.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/27/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public protocol APIModel: Codable {
    
    var id: Int? { get set }
    
    var createdAt: String? { get set }
    
    var updatedAt: String? { get set }
}

extension APIModel {
    
    public static func all(completionHandler: (([Self]?) -> ())? = nil) {
        let request = URLRequest.make(kind: .get, url: API.urlFor(self), body: nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            let models = API.decode([Self].self, from: data!)
            if let handler = completionHandler {
                handler(models)
            }
        } .resume()
    }
    
    public func get(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .get, url: API.urlFor(self), body: nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    public func post(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .post, url: API.urlFor(type(of: self)), body: API.encode(self))
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    public func patch(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .patch, url: API.urlFor(self), body: API.encode(self))
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
    
    public func delete(completionHandler: ((Data?, URLResponse?, Error?) -> ())? = nil) {
        let request = URLRequest.make(kind: .delete, url: API.urlFor(self), body: nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let handler = completionHandler {
                handler(data, response, error)
            }
        } .resume()
    }
}
