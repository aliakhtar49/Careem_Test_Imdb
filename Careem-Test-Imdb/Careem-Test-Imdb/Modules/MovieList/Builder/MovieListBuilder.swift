//
//  MovieListBuilder.swift
//  Careem-Test-Imdb
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit


protocol MoviesListBuilder {
    
    func build() -> UIViewController
}
class MoviesListBuilderImpl: MoviesListBuilder {
    
    func build() -> UIViewController {
        
        
        let storyboard = UIStoryboard(name: "MovieList", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        
        let viewModel = MovieListViewModelImp()
        let dataProvider = MovieListDataProviderImpl()
        dataProvider.movieService = MovieListServiceImpl()
        
        dataProvider.delegate = viewModel
        
        viewModel.movieListDataProvider = dataProvider
        viewController.viewModel = viewModel
        return viewController
    }
}
