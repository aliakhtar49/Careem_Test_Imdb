//
//  EndPoint.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

 //MARK: - HTTPMethod

public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//MARK: - Base Path (Environment)
public enum BasePath: String {
    case development = "https://api.themoviedb.org/"
}

//MARK: - EndPoint
public struct Endpoint {
    
    //MARK: - Properties
    private let method: HTTPMethod
    private let endpoint: String
    private let parameters: [String: String]?
    private let basePath: BasePath
    let headers: [String: String]?
    
    
    private var url: URL? {
        
        guard var components = URLComponents(string: basePath.rawValue + endpoint) else { return nil }
        guard let parameters = parameters else { return components.url! }
    
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    //MARK: - Init
    public init(
        method: HTTPMethod,
        endpoint: String,
        parameters: [String: String]? = nil,
        basePath: BasePath = BasePath.development,
        headers: [String: String]? = nil
        ) {
        
        self.method = method
        self.endpoint = endpoint
        self.parameters = parameters
        self.headers = headers
        self.basePath = basePath
        
    }
    
    //TODO: - Need to add paramter encoding on Body for POST Request
    
    //MARK: - Method
    func urlRequest() -> URLRequest? {
        
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach({ (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
        return request
    }
    
}

extension URLRequest {
    
}
