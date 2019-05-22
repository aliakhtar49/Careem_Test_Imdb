//
//  MovieListDataProvider.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

//MARK: - Delegates Protocol
protocol MovieListDataProviderDelegate: class {
    
    func onSuccess(_ upcomingMovies: UpcomingMovies)
    func onFailure(_ error: NetworkError)
}


//MARK: - MovieListDataProvider Protocol
protocol MovieListDataProvider {

    func providePaginatedUpcomingMovies()
    var delegate: MovieListDataProviderDelegate? { get set }
}

//MARK: - MovieListDataProvider Protocol Implementation
class MovieListDataProviderImpl: MovieListDataProvider {
    
    //MARK: - Injected Properties
    var movieService: MovieListService!
    
    //MARK: - Private Properties
    private var pageCount = 1
    private var totalPages: Int = 1
    private var isFetching = false
    
    //MARK: - Computed Properties
    weak var delegate: MovieListDataProviderDelegate?
    
    //MARK: - Methods
    func providePaginatedUpcomingMovies() {
        
        if pageCount <= totalPages && isFetching == false {
            
            isFetching = true
            movieService.getUpcomingMovies(on: pageCount) { [weak self] (result) in
                
                guard let self = self else { return }
        
                self.isFetching = false
                
                switch result {
                    
                case .success(let upcomingMovies):
                    self.pageCount = upcomingMovies.page + 1
                    self.totalPages = upcomingMovies.total_pages 
                    self.delegate?.onSuccess(upcomingMovies)
                    
                case .failure(let error):
                    self.delegate?.onFailure(error)

                }
                
            }
        }
    }
    
}
