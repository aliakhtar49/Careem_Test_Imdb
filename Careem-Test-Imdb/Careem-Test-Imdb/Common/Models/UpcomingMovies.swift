//
//  UpcomingMoviesModel.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

struct UpcomingMovies : Codable {
    
    let results : [Movie]?
    let page : Int
    let total_results : Int
    let total_pages : Int
    
    enum CodingKeys: String, CodingKey {
        
        case results = "results"
        case page = "page"
        case total_results = "total_results"
        case total_pages = "total_pages"
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        results = try values.decodeIfPresent([Movie].self, forKey: .results)
//        page = try values.decodeIfPresent(Int.self, forKey: .page)
//        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
//        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
//    }
    
}
