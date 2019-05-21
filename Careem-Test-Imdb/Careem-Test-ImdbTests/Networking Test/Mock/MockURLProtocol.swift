//
//  MockURLProtocol.swift
//  Careem-Test-ImdbTests
//
//  Created by Ali Akhtar on 21/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse?, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        returnMockResponse()
    }
    override func stopLoading() {
        returnMockResponse()
    }
    
    func returnMockResponse() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data, error) = try handler(request)
            
            if let response = response { client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed) }
            if let data = data { client?.urlProtocol(self, didLoad: data);  client?.urlProtocolDidFinishLoading(self) }
            if let error = error { client?.urlProtocol(self, didFailWithError: error) }
            
        }catch{
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}
