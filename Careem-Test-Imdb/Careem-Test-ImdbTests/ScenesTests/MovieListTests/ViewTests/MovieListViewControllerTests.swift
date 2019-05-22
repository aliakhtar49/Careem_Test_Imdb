//
//  MovieListViewControllerTests.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 22/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
@testable import Careem_Test_Imdb

class MovieListViewControllerTests: XCTestCase {

   
    var  viewModel: MockMovieListViewModelImpl!
    var  view: MovieListViewController!
    let mockTableView = UITableView()
    
    override func setUp() {
        
        viewModel = MockMovieListViewModelImpl()
        let storyboard = UIStoryboard(name: "MovieList", bundle: Bundle.main)
        view = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController
        view.viewModel = viewModel
        view.loadView()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK - testOnRightBarButtonTapped
    func testOnRightBarButtonTappedTriggeredViewModelProperMethod() {
        
        view.onRightBarButtonTapped(view.rightBarButton)
        
        XCTAssertTrue(viewModel.isTapOnResetOrFilterButton == true)
    }
    
    //MARK - testOnRightBarButtonTapped
    func testNumberOfRowsInSectionTriggeredViewModelProperMethod() {
        
        _ = view.tableView(view.movieListTableview, numberOfRowsInSection: 1)
        
        XCTAssertTrue(viewModel.isNumberOfRowsCalls == true)
    }
    
    
    //MARK - testOnRightBarButtonTapped
    func testCellDidSelectForRowAtIndexTriggeredViewModelProperMethod() {
        let indexPath = IndexPath(row: 0, section: 1)
        _ = view.tableView(view.movieListTableview, didSelectRowAt: indexPath)
        
        XCTAssertTrue(viewModel.isDidSelectRowCalls == true)
    }
    
    

}




