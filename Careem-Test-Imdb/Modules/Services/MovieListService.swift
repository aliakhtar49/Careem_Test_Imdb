//
//  MovieListService.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation


typealias UpcomingMovieResponse = (UpcomingMovies?, Error?) -> Void



//MARK: - Movie List Service  Protocol
protocol MovieListService {
    
    func getUpcomingMovies(on page: Int, completion: @escaping (UpcomingMovieResponse) )
}



//MARK: - Movie List Service  Protocol Implementation
class MovieListServiceImpl: MovieListService {
    
    //MARK: - Properties
    let translationLayer: TranslationLayer
    let networkManager: Networking
    
    //MARK: - Init
    init(translationLayer: TranslationLayer = JSONTranslation(), networkManager: Networking = NetworkManager() ) {
        self.translationLayer = translationLayer
        self.networkManager = networkManager
    }
    
    //MARK: - Method
    func getUpcomingMovies(on page: Int, completion: @escaping (UpcomingMovieResponse) ) {
        
        let endPoint = Endpoint(method: .get, endpoint: "3/movie/upcoming",parameters:["api_key":"d12b2746c7eaafbfdcf204463e26ff70","language":"en-US","page":"\(page)"])
        
        networkManager.request(endPoint) { (result) in
            switch result {
            case .success(let data):
                completion((self.translationLayer.translateToObject(withData: data)),nil)
                
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}
