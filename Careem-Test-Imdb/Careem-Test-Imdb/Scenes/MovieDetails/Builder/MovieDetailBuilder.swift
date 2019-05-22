//
//  MovieDetailBuilder.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation


import UIKit


protocol MovieDetailBuilder {
    
    func build(withMovie movie: Movie?) -> UIViewController
}
class MovieDetailBuilderImpl: MovieDetailBuilder {
    
    func build(withMovie movie: Movie?) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        let viewModel = MovieDetailViewModelImp(movie)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
