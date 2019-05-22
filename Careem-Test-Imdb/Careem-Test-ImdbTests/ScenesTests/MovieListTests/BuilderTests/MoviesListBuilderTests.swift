//
//  MoviesListBuilderTests.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
@testable import Careem_Test_Imdb

class MoviesListBuilderTests: XCTestCase {
    
    var builder: MoviesListBuilder!
    var view: MovieListViewController!

    override func setUp() {
        
        builder = MoviesListBuilderImpl()
        view = builder.build()
      
    }

    override func tearDown() {
        builder = nil
        view = nil
    }

    func testBuilderBuildViewModelProperly() {
        //Given
        
        //When
        
        //Then
        XCTAssertTrue(view.viewModel != nil)
        XCTAssertTrue(view.viewModel.movieListCoordinator != nil)
        XCTAssertTrue(view.viewModel.movieListDataProvider != nil)
        
    }

    func testBuilderBuildViewControllerProperly() {
        //Given
        
        //When
        
        //Then
        XCTAssertTrue(view != nil)
        
    }
   

}
