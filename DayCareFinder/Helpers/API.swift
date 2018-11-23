//
//  API.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/21/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public class API {
    
    public static let url: URL = URL(string: "https://day-care-finder.herokuapp.com")!
    
    public static var sessionURL: URL {
        return API.url.appendingPathComponent("sign_in")
    }
    
    private static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    public static func encode<T: APIModel>(_ object: T) -> Data {
        return try! API.encoder.encode([API.camelCaseClassName(object): object])
    }
    
    public static func encode<T: APIModel>(_ objects: [T]) -> Data {
        let elementClassName = API.camelCaseClassName(type(of: objects).Element.self)
        return try! API.encoder.encode([elementClassName.pluralized: objects])
    }
    
    public static func decode<T: APIModel>(_ type: T.Type, from data: Data) -> T {
        return try! API.decoder.decode(type, from: data)
    }
    
    public static func decode<T: APIModel>(_ type: [T].Type, from data: Data) -> [T] {
        return try! API.decoder.decode(type, from: data)
    }
    
    public static func urlFor<T: APIModel>(_ type: T.Type) -> URL {
        return self.url.appendingPathComponent(API.camelCaseClassName(type).pluralized)
    }
    
    public static func urlFor<T: APIModel>(_ object: T) -> URL {
        return self.urlFor(type(of: object)).appendingPathComponent(String(object.id!))
    }
    
    private static func camelCaseClassName<T>(_ object: T) -> String {
        return API.camelCaseClassName(type(of: object))
    }
    
    private static func camelCaseClassName<T>(_ type: T.Type) -> String {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonSymbols = CharacterSet(charactersIn: "[]{}:\"")
        let className = String(String(describing: type).components(separatedBy: ".").last!)
        let data = try! encoder.encode([className: ""])
        return String(data: data, encoding: .utf8)!.trimmingCharacters(in: jsonSymbols)
    }
}
