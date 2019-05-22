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
    var movieTitleText: String
    var movieDescription: String
    var moviePosterUrl: String
    var movieReleaseDate: String
    
    var movie: Movie?
    
    
    //MARK: - Init
    init(_ movie: Movie?) {
       
                self.movieTitleText = movie?.title ?? ""
                self.movieDescription = movie?.overview ?? ""
                self.moviePosterUrl = Constants.IMDB_IMAGE_BASE_URL + (movie?.poster_path ?? "")
                self.movieReleaseDate = movie?.release_date ?? ""
    }
    
}
