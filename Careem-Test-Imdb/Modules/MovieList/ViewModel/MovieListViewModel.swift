//
//  MovieListViewModel.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit


typealias MoviesViewModelOutput = (MovieListViewModel.Output) -> ()

//MARK: - MovieListViewModel
class MovieListViewModel {
    
    enum Output {
        case reloadMovies
        case showActivityIndicator(show: Bool)
        case showError(error: Error)
    }
    
    //MARK: - Properties
    var output: MoviesViewModelOutput?
    var movieService = MovieListServiceImpl()
    var pageCount = 1
    var movieListCellViewModels = [MovieListTableCellViewModel]()
    var totalPages: Int = 1
    
    var numberOfRows: Int {
        return movieListCellViewModels.count
    }
    
    //MARK: - Methods
    func getMovieListCellViewModel(index : Int) -> MovieListTableCellViewModel {
        return self.movieListCellViewModels[index]
    }
    
    func getUpcomingMovies() {
        if pageCount <= totalPages {
            movieService.getUpcomingMovies(on: pageCount) { [weak self] (result) in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let upcomingMovies):
                    self.upcomingListFetch(with: upcomingMovies)
                    
                case .failure(let error):
                    self.output?(.showError(error: error))
                }
                
            }
        }
    }
    func upcomingListFetch(with data: UpcomingMovies) {
        
        guard let results = data.results,
            let pageCount = data.page,
            let totalPages = data.total_pages else {
            return
        }
        
        self.pageCount = pageCount
        self.totalPages = totalPages
        
        let movieListTableCellViewModels =  results.map { (movie) -> MovieListTableCellViewModel in
            MovieListTableCellViewModel(movieTitleText: movie.title, movieDescription: movie.overview, moviePosterUrl: movie.poster_path, movieReleaseDate: movie.release_date)
        }
        movieListCellViewModels.append(contentsOf: movieListTableCellViewModels)
        
        self.output?(.reloadMovies)
    }
}
