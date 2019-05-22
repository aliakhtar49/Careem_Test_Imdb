//
//  MovieDetailBuilderTests.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
@testable import Careem_Test_Imdb

class MovieDetailBuilderTests: XCTestCase {

    var builder: MovieDetailBuilder!
    var view: MovieDetailViewController!
    
    override func setUp() {
        
        builder = MovieDetailBuilderImpl()
        let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
        view = builder.build(withMovie: upcomingMovies.results?.first)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuilderBuildViewModelProperly() {
        //Given
        
        //When
        
        //Then
        XCTAssertTrue(view.viewModel != nil)

    }
    func testBuilderBuildViewControllerProperly() {
        //Given
        
        //When
        
        //Then
        XCTAssertTrue(view != nil)
        
    }


}
