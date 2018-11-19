//
//  APIPathRepresentable.swift
//  DayCareFinder
//
//  Created by Jared Payne on 10/27/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public protocol APIModel: Codable {
    
    var id: Int? { get }
}

public extension APIModel {
    
    static var modelNamespace: String {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let trimCharacterSet = CharacterSet(charactersIn: "\":{}[]")
        let data = try! encoder.encode([String(describing: Self.self): ""])
        // Pluralization could be imporved here, but this does the job for our purposes.
        return String(data: data, encoding: .utf8)!.trimmingCharacters(in: trimCharacterSet) + "s"
    }
    
    static func all(completionHandler: @escaping ([Self]?) -> ()) {
        API.index(type: Self.self, completionHandler: completionHandler)
    }
    
    static func find(id: Int, completionHandler: @escaping (Self?) -> ()) {
        API.show(type: Self.self, id: id, completionHandler: completionHandler)
    }
    
    static func save(_ object: Self, completionHandler: @escaping (Error?) -> ()) {
        API.create(object: object, completionHandler: completionHandler)
    }
    
    static func destroy(_ object: Self, completionHandler: @escaping (Error?) -> ()) {
        API.destroy(object: object, completionHandler: completionHandler)
    }
}
