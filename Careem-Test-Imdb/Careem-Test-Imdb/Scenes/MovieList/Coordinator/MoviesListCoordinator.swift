//
//  MoviesListCoordinator.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesListCoordinator {
   func navigateToMovieDetail(movie: Movie?)
}

class MoviesListCoordinatorImpl: MoviesListCoordinator {
    weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
}


extension MoviesListCoordinatorImpl {
    
    func navigateToMovieDetail(movie: Movie?) {
       let detailController = MovieDetailBuilderImpl().build(withMovie: movie)
        self.view?.navigationController?.pushViewController(detailController, animated: true)
    }
}
