//
//  API
//  DayCareFinder
//
//  Created by Jared Payne on 10/27/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import Foundation

public class API {
    
    public static let baseURL: URL = URL(string: "https://day-care-finder.herokuapp.com")!
    
    public static func index<T>(type: T.Type, completionHandler: @escaping ([T]?) -> ()) where T: APIModel {
        let url = URL(string: "\(type.modelNamespace).json", relativeTo: API.baseURL)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let objectsData = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let objects = try? decoder.decode([T].self, from: objectsData)
            completionHandler(objects)
        } .resume()
    }
    
    public static func show<T>(type: T.Type, id: Int, completionHandler: @escaping (T?) -> ()) where T: APIModel {
        let url = URL(string: "\(type.modelNamespace)/\(id).json", relativeTo: API.baseURL)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let objectData = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let object = try? decoder.decode(T.self, from: objectData)
            completionHandler(object)
        } .resume()
    }
    
    public static func create<T>(object: T, completionHandler: @escaping (Error?) -> ()) where T: APIModel {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        var request = URLRequest(url: URL(string: "\(type(of: object).modelNamespace).json", relativeTo: API.baseURL)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? encoder.encode(object)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, response, error in
            completionHandler(error)
        } .resume()
    }
    
    public static func destroy<T>(object: T, completionHandler: @escaping (Error?) -> ()) where T: APIModel {
        var request =  URLRequest(url: URL(string: "\(type(of: object).modelNamespace)/\(object.id!).json", relativeTo: API.baseURL)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            completionHandler(error)
        } .resume()
    }
}
