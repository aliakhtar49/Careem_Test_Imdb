//
//  NetworkError.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

//MARK: - Network Error

enum NetworkError: Error {
  
    //MARK: - Cases
    case requestCreation
    case decoding(Error)
    case server(Error)
    case unknown


}

//MARK: - Custom Messages
extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .requestCreation:
            return "Request could not be created."
        case .decoding(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .server(let error):
            return error.localizedDescription
        case .unknown:
            return "Unknown, known error."
        }
        
    }
}


