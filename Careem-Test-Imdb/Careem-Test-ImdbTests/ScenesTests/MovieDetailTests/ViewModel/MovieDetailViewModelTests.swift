//
//  MovieDetailViewModelTests.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
@testable import Careem_Test_Imdb

class MovieDetailViewModelTests: XCTestCase {

   
    var  viewModel: MovieDetailViewModel!
    var  view = MockMovieDetailViewController()
    
    override func setUp() {
        
       
        
    }
    
    override func tearDown() {
        viewModel = nil
    }

    func testViewDidLoad() {
        //Given
        let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
        viewModel = MovieDetailViewModelImp(upcomingMovies.results?.first)
        view.viewModel = viewModel
        view.bindViewModelOutput()
        
        //When
        viewModel.viewDidLoad()
        
        //Then
        XCTAssertTrue(view.isMovieBannerImageViewCalls == true)
        XCTAssertTrue(view.isShowMovieTitleCalls == true)
        XCTAssertTrue(view.isShowMovieReleaseDate == true)
        XCTAssertTrue(view.isShowMovieDescriptionCalls == true)
        XCTAssertTrue(view.isShowMovieGenreCalls == true)
        XCTAssertTrue(view.isShowMovieLanguageCalls == true)
        XCTAssertTrue(view.isShowMovieRatingCalls == true)
        
        
    }
    
    func testViewDidLoaddd() {
        //Given
        let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieNilStub)
        let viewModel = MovieDetailViewModelImp(upcomingMovies.results?.first)
        view.viewModel = viewModel
        view.bindViewModelOutput()
        
        //When
        viewModel.viewDidLoad()
        
        //Then
        XCTAssertTrue(view.isMovieBannerImageViewCalls == true)
        XCTAssertTrue(view.isShowMovieTitleCalls == true)
        XCTAssertTrue(view.isShowMovieReleaseDate == true)
        XCTAssertTrue(view.isShowMovieDescriptionCalls == true)
        XCTAssertTrue(view.isShowMovieGenreCalls == false)
        XCTAssertTrue(view.isShowMovieLanguageCalls == true)
        XCTAssertTrue(view.isShowMovieRatingCalls == true)
        
        
    }
}

