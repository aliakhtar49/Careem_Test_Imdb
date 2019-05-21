//
//  NetworkManagerTests.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
@testable import Careem_Test_Imdb

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - Test Success Case
    
    //Test proper data is proper map from Server and the model class
    func testSuccessResponseFromServer() {
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)
        
        let networkManger = NetworkManager(session: mockSession)
        
        MockURLProtocol.requestHandler =  { request in
            return (nil, upcomingMovieSuccessStub ,nil)
        }
    
        let endPoint = Endpoint(method: .get)
        networkManger.request(endPoint) { (result) in
            if case let .success(data) = result {
                let upcomingMovie = try! JSONDecoder().decode(UpcomingMovies.self, from: upcomingMovieSuccessStub)
                print(data.count)
                XCTAssertTrue(upcomingMovie.page == 1)
                XCTAssertTrue(upcomingMovie.total_pages == 17)
            }
        }
    }

 
    //MARK: - Test Failure Case
    
    //Test error  is mapping  from server and Model class
    func testInternetConnectionFailureResponseFromServer() {
        
        let error = NSError(domain: NSURLErrorDomain, code: -1009, userInfo: [NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)
        
        let networkManger = NetworkManager(session: mockSession)
    
        MockURLProtocol.requestHandler =  { request in
            return (nil, nil ,error)
        }
        
        let endPoint = Endpoint(method: .get)
        networkManger.request(endPoint) { (result) in
            if case let .failure(error) = result {
                XCTAssertTrue(error.localizedDescription == "The Internet connection appears to be offline.")
            }
        }
        
    }
    
    //Test error  is mapping  from server and Model class
    func testUnkownErrorFailureResponseFromServer() {
        
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: sessionConfiguration)
        
        let networkManger = NetworkManager(session: mockSession)
        
        MockURLProtocol.requestHandler =  { request in
            return (nil, nil ,nil)
        }
        
        let endPoint = Endpoint(method: .get)
        networkManger.request(endPoint) { (result) in
            if case let .failure(error) = result {
                XCTAssertTrue(error.localizedDescription == "Unknown, known error.")
            }
        }
        
    }
    
    func testRequestCreationFailureResponse() {
        
        let endPoint = Endpoint(method: .get, route: "\todos",basePath: BasePath.test)
        let networkManger = NetworkManager()
        networkManger.request(endPoint) { (result) in
            if case let .failure(error) = result {
                XCTAssertTrue(error.localizedDescription == "Request could not be created.")
            }
        }
       
        
    }
    
    

}
