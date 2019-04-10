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

}
