//
//  MovieListService.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation


//typealias UpcomingMovieResponse = (UpcomingMovies?, Error?) -> Void

typealias UpcomingMovieResponse = (Result<UpcomingMovies,NetworkError>) -> Void





//MARK: - Movie List Service  Protocol
protocol MovieListService {

    func getUpcomingMovies(on page: Int, completion: @escaping (UpcomingMovieResponse) )
}



//MARK: - Movie List Service  Protocol Implementation
class MovieListServiceImpl: MovieListService {
    
     static let MOVIE_LIST_API_ROUTE = "3/movie/upcoming"
    
    
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
        
        let endPoint = Endpoint(method: .get, route: MovieListServiceImpl.MOVIE_LIST_API_ROUTE,parameters:["api_key":Constants.IMDB_API_KEY,"language":"en-US","page":"\(page)"])
        print("EndPoint Hittings\(endPoint.urlRequest()?.url)")
        
        networkManager.request(endPoint) { (result) in
           
            switch result {
            case .success(let data):
                do {
                    let upcomingMovies: UpcomingMovies = try self.translationLayer.translateToObject(withData: data)
                    completion(.success(upcomingMovies))
                    
                }catch {
                    completion(.failure(NetworkError.decoding(data, error)))
                    
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
