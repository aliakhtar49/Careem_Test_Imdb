//
//  JSONTranslator.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

//MARK: - TranslationLayer Protocol
protocol TranslationLayer {

    func translateToObject<T: Decodable>(withData data: Data) throws -> T
}



//MARK: - TranslationLayer Protocol Implmentation
class JSONTranslation: TranslationLayer {
    
    func translateToObject<T: Decodable>(withData data: Data) throws -> T {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
    }
}
