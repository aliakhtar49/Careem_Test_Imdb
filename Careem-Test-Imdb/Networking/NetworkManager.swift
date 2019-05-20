//
//  NetworkManager.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation



//MARK: - Netwworking Protocol
protocol Networking {
    
    func request(_ request: Endpoint,completion: @escaping ((Result) -> Void))
}

//MARK: - Netwworking Protocol Implementation
public class NetworkManager : Networking {
    
    //MARK: - Properties
    private let session: URLSession
    
    //MARK: - Init
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    //MARK: - Methods
    func request(_ endPoint: Endpoint,completion: @escaping ((Result) -> Void)) {
        
        guard let request =  endPoint.urlRequest() else {
            completion(.failure(NetworkError.requestCreation))
            return
        }
        
        //Url Session Task creation
        session.dataTask(with: request) { (data, response, error) in
            
              let result: Result
                if let error = error {
                    result = .failure(NetworkError.server(error))
                }
                else if let data = data {
                    result = .success(data)
                    
                } else {
                    result = .failure(NetworkError.unknown)
                }
            
                DispatchQueue.main.async {
                    completion(result)
                }
            }.resume()
    }
    
}


