//
//  MovieListTableCellViewModel.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

//MARK: - MovieListViewModel

struct MovieListTableCellViewModel {
    
     //MARK: - Properties
    var movieTitleText: String?
    var movieDescription: String?
    var moviePosterUrl: String?
    var movieReleaseDate: String?
    
    
     //MARK: - Init
    init(movieTitleText: String?, movieDescription: String?,moviePosterUrl: String?,movieReleaseDate: String?) {
        self.movieTitleText = movieTitleText
        self.movieDescription = movieDescription
        self.moviePosterUrl = Constants.IMDB_IMAGE_BASE_URL + (moviePosterUrl ?? "")
        self.movieReleaseDate = movieReleaseDate
    }
    
    
}
