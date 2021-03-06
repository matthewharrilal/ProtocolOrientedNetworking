//
//  HTTPClientTesrt.swift
//  ProtocolOrientedNetworkingTests
//
//  Created by Matthew Harrilal on 4/10/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import XCTest
@testable import ProtocolOrientedNetworking

// What else can be tested maybe the actual networking layer?

class HttpClientTests: XCTestCase {
    var httpClient: HttpClient!
    
    let mockSession = MockURLSession() // Takes the place of URLSession.shared
    
    override func setUp() {
        super.setUp()
        
        // Instantiate our HTTPClient
        httpClient = HttpClient(session: mockSession)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_request_was_made() {
        guard let url = URL(string: "https://example.com") else {return}
        
        httpClient.get(url: url) { (data, error) in
            // No need to do anything just testing if request was made
        }
        
        XCTAssertEqual(url, mockSession.lastURL)
    }
    
    func test_task_was_started() {
        guard let url = URL(string: "https://example.com") else {return}
        
        httpClient.get(url: url) { (data, error) in
            // Doesn't matter because we are just checking if the network request was actually kicked off
        }
        
        XCTAssert(mockSession.nextDataTask.resumeWasCalled)
    }
    
    func test_data_was_returned() {
        guard let url = URL(string: "https://example.com") else {return}
        
        let stubbedData = "{}".data(using: .utf8)
        
        mockSession.nextData = stubbedData // Now that we have set the data
        
        var returnedData: Data?
        httpClient.get(url: url) { (data, error) in
            
            // Check whether the completion handler returned the data
            returnedData = data
        }
        
        XCTAssertNotNil(returnedData) // Mark if the data has been set
    }

}
