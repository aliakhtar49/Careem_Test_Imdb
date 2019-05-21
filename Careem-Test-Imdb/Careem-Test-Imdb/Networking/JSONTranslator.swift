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
    
    func translateToMap<T: Encodable>(withModel model: T) -> [String: Any]?
    func translateToData<T: Encodable>(withModel model: T) -> Data?
    func translateToObject<T: Decodable>(withData data: Data) throws -> T
    //func translateToObject<T: Decodable>(withData data: Data) -> T?
    
}



//MARK: - TranslationLayer Protocol Implmentation
class JSONTranslation: TranslationLayer {
    
    func translateToMap<T: Encodable>(withModel model: T) -> [String: Any]? {
        
        do {
            
            let encodedData = try JSONEncoder().encode(model)
            return try JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String: Any]
            
        } catch let error {
            
            print(error)
            return nil
        }
    }
    
    func translateToData<T: Encodable>(withModel model: T) -> Data? {
        
        do {
            
            return try JSONEncoder().encode(model)
            
        } catch let error {
            
            print(error)
            return nil
        }
    }
    
//    func translateToObject<T: Decodable>(withData data: Data) -> T? {
//
//        do {
//
//            let decoder = JSONDecoder()
//            return try decoder.decode(T.self, from: data)
//
//        } catch let error {
//
//            print(error)
//            return nil
//        }
//
//    }
    func translateToObject<T: Decodable>(withData data: Data) throws -> T {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
    }
}
