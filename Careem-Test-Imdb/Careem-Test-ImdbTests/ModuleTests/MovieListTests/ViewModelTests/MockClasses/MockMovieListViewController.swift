//
//  MockMovieListViewController.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
@testable import Careem_Test_Imdb

class MockMovieListViewController: MovieListViewController {
    
    var isShowLoaderCalls = false
    var isReloadMoviesCalls = false
    var isShowErrorCalls = false
    var isShowDatePickerCalls = false
    var isShowFilterImageCalls = false
    
    
    override func bindViewModelOutput() {
        
        viewModel.output = { [weak self] output in
            
            guard let self = self else { return }
            switch output {
            case .reloadMovies:
                self.isReloadMoviesCalls = true
            case .showLoader( _):
                self.isShowLoaderCalls = true
            case .showError( _):
                self.isShowErrorCalls = true
            case .showDatePicker( _):
                self.isShowDatePickerCalls = true
            case .showFilterImage( _):
                self.isShowFilterImageCalls = true
            }
        }
    }
    
}
