//
//  Endpoint.swift
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
    case test = "http://someurl.com"
}

//MARK: - EndPoint
public struct Endpoint {
    
    //MARK: - Properties
    private let method: HTTPMethod
    private let route: String
    private let parameters: [String: String]?
    private let basePath: BasePath
    let headers: [String: String]?
    
    
    private var url: URL? {
        
        guard var components = URLComponents(string: basePath.rawValue + route) else { return nil }
        components.queryItems = parameters?.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    //MARK: - Init
    public init(
        method: HTTPMethod,
        route: String = "",
        parameters: [String: String]? = nil,
        basePath: BasePath = BasePath.development,
        headers: [String: String]? = nil
        ) {
        
        self.method = method
        self.route = route
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
        request.setHeaders(headers)
        
        return request
    }
    
}


