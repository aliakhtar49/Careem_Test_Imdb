//
//  URLRequest+Extensions.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

//MARK: - URLRequest Extension

extension URLRequest {
    
    mutating func setHeaders(_ headers: [String: String]?)  {

        headers?.forEach({ (key, value) in
            setValue(value, forHTTPHeaderField: key)
        })
    }
}
