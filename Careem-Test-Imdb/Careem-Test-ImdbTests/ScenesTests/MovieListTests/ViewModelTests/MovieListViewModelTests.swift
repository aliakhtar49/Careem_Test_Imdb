//
//  MovieListViewModelTests.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
@testable import Careem_Test_Imdb

class MovieListViewModelTests: XCTestCase {
    
    var  mockListDataProvider: MockMovieListDataProvider!
    var  viewModel: MovieListViewModelImp!
    var  view = MockMovieListViewController()

    override func setUp() {
        
        mockListDataProvider = MockMovieListDataProvider()
        
        viewModel = MovieListViewModelImp(mockListDataProvider,MoviesListCoordinatorImpl(view: UIViewController()))
        mockListDataProvider.delegate = viewModel
        view.viewModel = viewModel
        view.bindViewModelOutput()
       
    }

    override func tearDown() {
        mockListDataProvider = nil
        viewModel = nil
    }

    //MARK: -  Success Case
    
    //// - testGetUpcomingMoviesOnSuccessCraetingProperMovieCellViewModel
    func testGetUpcomingMoviesMethodOnSuccess() {
        
        
        //Given Upooming Movies Successfully Fetch and Decode \
        mockListDataProvider.closure = { [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }
        
        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.getUpcomingMovies()
        
        //Then
         let cellViewModel = viewModel.getMovieListCellViewModel(index: 0)
         XCTAssert(cellViewModel.movieTitleText == "John Wick: Chapter 3 – Parabellum")
    
    }
    //MARK: -  Failure Case
    
    //// - testGetUpcomingMoviesMethodOnFailureWithUnknownError
    func testGetUpcomingMoviesMethodOnFailureWithUnknownError() {
        
        
        //Given
        mockListDataProvider.closure = { [unowned self] in
            self.mockListDataProvider.delegate?.onFailure(NetworkError.unknown)
        }
        
        //When getUpcomingMovies method on View model Failed to fetch Upcoming Movies
        viewModel.getUpcomingMovies()
        
        //Then
        XCTAssert(view.isShowErrorCalls == true)
        
    }
    //// - testGetUpcomingMoviesMethodOnFailure
    func testGetUpcomingMoviesMethodOnFailureWithServerError() {
        
        
        //Given
        let error = NSError(domain: NSURLErrorDomain, code: -1009, userInfo: [NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
        mockListDataProvider.closure = { [unowned self] in
            self.mockListDataProvider.delegate?.onFailure(NetworkError.server(error))
        }
        
        //When getUpcomingMovies method on View model Failed to fetch Upcoming Movies
        viewModel.getUpcomingMovies()
        
        //Then
        XCTAssert(view.isShowErrorCalls == true)
        
    }
    
    
    
    
    //MARK: -  Success Case

    //// - testViewModelViewModelDidLoad On success Api Call
    func testViewModelDidLoadOnSuccessServerCall() {

        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }

        //When
        viewModel.viewDidLoad()

        //Then
        let cellViewModel = viewModel.getMovieListCellViewModel(index: 0)
        XCTAssert(cellViewModel.movieTitleText == "John Wick: Chapter 3 – Parabellum")

    }

    //// - testViewModelTableViewDidReachToEndOnSuccessServerCall
    func testViewModelTableViewDidReachToEndOnSuccessServerCall() {

        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }

        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.tableViewDidReachToEnd()

        //Then
        let cellViewModel = viewModel.getMovieListCellViewModel(index: 0)
        XCTAssert(cellViewModel.movieTitleText == "John Wick: Chapter 3 – Parabellum")

    }

    //// - testViewModelOnTapOnResetOrFilterButtonWhenFilterIsActive
    func testViewModelOnTapOnResetOrFilterButtonWhenFilterIsActive() {


        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }

        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.isFilteringActive = true
        viewModel.onTapOnResetOrFilterButton()

        //Then
        XCTAssert(viewModel.isFilteringActive == false)
    }
    //// - testViewModelOnTapOnResetOrFilterButtonWhenFilterIsInActive
    func testViewModelOnTapOnResetOrFilterButtonWhenFilterIsInActive() {
        
        
        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }
        
        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.onTapOnResetOrFilterButton()
        
        //Then
        XCTAssert(viewModel.isFilteringActive == false)
        XCTAssert(view.isShowDatePickerCalls == true)
    }

    //// - testViewModelDidCancelFiltering
    func testViewModelDidCancelFiltering() {

        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }

        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.didCancelFiltering()

        //Then
        XCTAssert(view.isShowDatePickerCalls == true)

    }
    
    //// - testViewModelDidSelectFilteringWhenNoData
    func testViewModelDidSelectFilteringWithNoData() {
        
        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }
        
        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.didSelectFiltering(with: Date())
        
        //Then
        XCTAssert(viewModel.isFilteringActive == true)
        XCTAssert(view.isShowDatePickerCalls == true)
        
    }
    //// - testViewModelDidSelectFilteringWhenNoData
    func testViewModelDidSelectFilteringWithData() {
        
        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }
        
        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.getUpcomingMovies()
        viewModel.didSelectFiltering(with: Date())
        
        //Then
        XCTAssert(viewModel.isFilteringActive == true)
        XCTAssert(view.isShowDatePickerCalls == true)
        
    }
    
    //// - testViewModelNumberOfRowsWhenFilteringIsAvtive
    func testViewModelNumberOfRowsWhenFilteringIsAvtive() {
        
        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }
        
        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.getUpcomingMovies()
        viewModel.isFilteringActive = true
       
        
        //Then
        XCTAssert(viewModel.numberOfRows == 0)
        
    }
    //// - testViewModelNumberOfRowsWhenFilteringIsInAvtive
    func testViewModelNumberOfRowsWhenFilteringIsInAvtive() {
        
        //Given
        mockListDataProvider.closure = {  [unowned self] in
            let upcomingMovies = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
            self.mockListDataProvider.delegate?.onSuccess(upcomingMovies)
        }
        
        //WHen getUpcomingMovies method on View model fetches Upcoming Movies
        viewModel.getUpcomingMovies()
        viewModel.isFilteringActive = false
        
        
        //Then
        XCTAssert(viewModel.numberOfRows == 1)
        
    }



    


}




