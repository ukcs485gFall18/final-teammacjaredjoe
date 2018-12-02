//
//  API.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/21/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public class API {
    
    /// The database URL.
    public static let url: URL = URL(string: "https://day-care-finder.herokuapp.com")!
    
    /// The URL for signing in to the database API.
    public static var sessionURL: URL {
        return API.url.appendingPathComponent("sign_in")
    }
    
    /// The properly initialized `JSONEncoder` for encoding objects to send the API.
    private static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    /// The properly initialized `JSONDecoder` for decoding objects received from the API.
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    /// Encode an `APIModel` object.
    ///
    /// - parameter object: The object to encode.
    ///
    /// - returns: The encoded object as JSON data.
    public static func encode<T: APIModel>(_ object: T) -> Data {
        return try! API.encoder.encode([API.snakeCaseClassName(object): object])
    }
    
    /// Encode an array of `APIModel` objects.
    ///
    /// - parameter object: The array of objects to encode.
    ///
    /// - returns: The encoded objects as JSON data.
    public static func encode<T: APIModel>(_ objects: [T]) -> Data {
        let elementClassName = API.snakeCaseClassName(type(of: objects).Element.self)
        return try! API.encoder.encode([elementClassName.pluralized: objects])
    }
    
    /// Decode an `APIModel` object as a specific type.
    ///
    /// - parameter type: The type of the object being decoded.
    ///
    /// - returns: The decoded `APIModel` object as the given type.
    public static func decode<T: APIModel>(_ type: T.Type, from data: Data) -> T {
        return try! API.decoder.decode(type, from: data)
    }
    
    /// Decode an array of `APIModel` objects as a specific type.
    ///
    /// - parameter type: The type of the objects being decoded.
    ///
    /// - returns: The decoded `APIModel` objects as an array of the given type.
    public static func decode<T: APIModel>(_ type: [T].Type, from data: Data) -> [T] {
        return try! API.decoder.decode(type, from: data)
    }
    
    /// Generates the URL of the API endpoint for a given `APIModel` type.
    ///
    /// - parameter type: The `APIModel` type.
    ///
    /// - returns: The generated URL.
    public static func urlFor<T: APIModel>(_ type: T.Type) -> URL {
        return self.url.appendingPathComponent(API.snakeCaseClassName(type).pluralized)
    }
    
    /// Generates the URL of the API endpoint for a given `APIModel` object entry.
    ///
    /// - parameter type: The `APIModel` type.
    ///
    /// - returns: The generated URL.
    public static func urlFor<T: APIModel>(_ object: T) -> URL {
        return self.urlFor(type(of: object)).appendingPathComponent(String(object.id!))
    }
    
    /// Returns the class name of an `APIModel` object as snake case.
    private static func snakeCaseClassName<T>(_ object: T) -> String {
        return API.snakeCaseClassName(type(of: object))
    }
    
    /// Returns the class name of an `APIModel` type as snake case.
    private static func snakeCaseClassName<T>(_ type: T.Type) -> String {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonSymbols = CharacterSet(charactersIn: "[]{}:\"")
        let className = String(String(describing: type).components(separatedBy: ".").last!)
        let data = try! encoder.encode([className: ""])
        return String(data: data, encoding: .utf8)!.trimmingCharacters(in: jsonSymbols)
    }
}
