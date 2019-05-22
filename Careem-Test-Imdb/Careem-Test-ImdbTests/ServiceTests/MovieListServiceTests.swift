//
//  MovieListServiceTests.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
@testable import Careem_Test_Imdb


class MovieListServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - Test Success Case
    
    //Test
    func testUpcomingMovieModelDecodingSuccess() {
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)
        
        let mockNetworkManager = NetworkManager(session: mockSession)
        
        MockURLProtocol.requestHandler =  { request in
            return (nil, upcomingMovieSuccessStub ,nil)
        }
        
        MovieListServiceImpl(networkManager: mockNetworkManager).getUpcomingMovies(on: 2) { (result) in
            if case let .success(upcomingMovie) = result {
                XCTAssertTrue(upcomingMovie.page == 1)
                XCTAssertTrue(upcomingMovie.total_pages == 17)
            }

        }
    }
    
    func testUpcomingMovieModelDecodingFailed() {

        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)

        let mockNetworkManager = NetworkManager(session: mockSession)

        MockURLProtocol.requestHandler =  { request in
            return (nil, upcomingMovieDecodingFailedStub ,nil)
        }

        MovieListServiceImpl(networkManager: mockNetworkManager).getUpcomingMovies(on: 1) { (result) in
            if case let .failure(error) = result {
               XCTAssertTrue(error.localizedDescription == "Decoding failed: The data couldn’t be read because it isn’t in the correct format.")
            }

            
        }
    }
//
    func testUpcomingMovieMethodWithNoInternetConnection() {
        
         let error = NSError(domain: NSURLErrorDomain, code: -1009, userInfo: [NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)
        
        let mockNetworkManager = NetworkManager(session: mockSession)
        
        MockURLProtocol.requestHandler =  { request in
            return (nil, nil ,error)
        }
        
        MovieListServiceImpl(networkManager: mockNetworkManager).getUpcomingMovies(on: 1) { (result) in
            if case let .failure(error) = result {
                XCTAssertTrue(error.localizedDescription == "The Internet connection appears to be offline.")
            }
        }
    }



}
