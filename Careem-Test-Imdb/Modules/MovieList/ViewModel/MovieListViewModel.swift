//
//  MovieListViewModel.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 20/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

typealias MoviesViewModelOutput = (MovieListViewModel.Output) -> ()

class MovieListViewModel {
    
    enum Output {
        case reloadMovies
        case showActivityIndicator(show: Bool)
        case showError(error: Error)
    }
    
    var output: MoviesViewModelOutput?
}
