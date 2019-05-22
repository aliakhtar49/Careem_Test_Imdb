//
//  MockMovieListViewModelImpl.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
@testable import Careem_Test_Imdb
import UIKit


class MockMovieListViewModelImpl: MovieListViewModel {
    
    var isTapOnResetOrFilterButton = false
    var isNumberOfRowsCalls = false
    var isGetMovieListCellViewModelCalls = false
    var isDidSelectRowCalls = false
    
    var numberOfRows: Int {
        isNumberOfRowsCalls = true
        return 1
    }
    
    var output: MoviesViewModelOutput?
    
    func getMovieListCellViewModel(index: Int) -> MovieListTableCellViewModel {
        
        isGetMovieListCellViewModelCalls = true
        let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
        return MovieListTableCellViewModel(upcomingMovies.results?.first )
    }
    
    func didSelectRow(index: Int) {
        isDidSelectRowCalls = true
    }
    
    func viewModelDidLoad() {
        
    }
    
    func tableViewDidReachToEnd() {
        
    }
    
    func didCancelFiltering() {
        
    }
    
    func didSelectFiltering(with date: Date) {
        
    }
    
    func onTapOnResetOrFilterButton() {
        isTapOnResetOrFilterButton = true
    }
}
