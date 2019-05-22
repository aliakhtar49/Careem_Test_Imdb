//
//  MockMovieDetailViewController.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
@testable import Careem_Test_Imdb
import UIKit

class MockMovieDetailViewController: MovieDetailViewController {
    
    var isMovieBannerImageViewCalls = false
    var isShowMovieTitleCalls = false
    var isShowMovieReleaseDate = false
    var isShowMovieDescriptionCalls = false
    var isShowMovieGenreCalls = false
    var isShowMovieLanguageCalls = false
    var isShowMovieRatingCalls = false
    
    override func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            
            guard let self = self else { return }
            
            switch output {
            case .showMovieBannerImageView( _):
                self.isMovieBannerImageViewCalls = true
            case .showMovieTitle(_):
                self.isShowMovieTitleCalls = true
            case .showMovieReleaseDate( _):
                self.isShowMovieReleaseDate = true
            case .showMovieDescription( _):
                self.isShowMovieDescriptionCalls = true
            case .showMovieGenre( _):
                self.isShowMovieGenreCalls = true
            case .showMovieLanguage( _):
                self.isShowMovieLanguageCalls = true
            case .showMovieRating( _):
                self.isShowMovieRatingCalls = true
            }
        }
    }
}

