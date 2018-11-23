//
//  URLRequest.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/20/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

extension URLRequest {
    
    public enum Kind: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    public static func make(kind: Kind, url: URL, body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = kind.rawValue
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
