//
//  URLRequest.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/20/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

extension URLRequest {
    
    /// Represents a type of `URLRequest` method.
    public enum Kind: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    /// Conveniently generates a JSON `URLRequest` for the application API.
    ///
    /// - parameter kind: The HTTP method type.
    /// - parameter url: The URL at which to direct the request.
    /// - parameter body: The request body data.
    public static func make(kind: Kind, url: URL, body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = kind.rawValue
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let user = User.currentUser {
            request.addValue(user.email!, forHTTPHeaderField: "X-User-Email")
            request.addValue(user.authenticationToken!, forHTTPHeaderField: "X-User-Token")
        }
        return request
    }
}
