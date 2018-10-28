//
//  API
//  DayCareFinder
//
//  Created by Jared Payne on 10/27/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public class API {
    
    public static let baseURL: URL = URL(string: "http://localhost:3000")!
    
    public static func index<T>(type: T.Type, completionHandler: @escaping ([T]?) -> Void) where T: APIModel {
        let url = URL(string: "\(type.modelName).json", relativeTo: API.baseURL)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let objectsData = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let objects = try? decoder.decode([T].self, from: objectsData)
            completionHandler(objects)
        } .resume()
    }
    
    public static func show<T>(type: T.Type, id: Int, completionHandler: @escaping (T?) -> Void) where T: APIModel {
        let url = URL(string: "\(type.modelName)/\(id).json", relativeTo: API.baseURL)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let objectData = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let object = try? decoder.decode(T.self, from: objectData)
            completionHandler(object)
        } .resume()
    }
    
    public static func new<T>(object: T, completionHandler: @escaping (Error?) -> Void) where T: APIModel {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        var request = URLRequest(url: URL(string: "\(type(of: object).modelName).json", relativeTo: API.baseURL)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? encoder.encode(object)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, response, error in
            completionHandler(error)
        } .resume()
    }
    
    public static func destroy<T>(object: T, completionHandler: @escaping (Error?) -> Void) where T: APIModel {
        var request =  URLRequest(url: URL(string: "\(type(of: object).modelName)/\(object.id).json", relativeTo: API.baseURL)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            completionHandler(error)
        } .resume()
    }
}
