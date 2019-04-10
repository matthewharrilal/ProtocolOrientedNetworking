//
//  Mocks.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/10/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    // Returns a data task that can be marked as resumed that can be seen in the protocol below
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

class HttpClient {
    typealias completeClosure = (_ data: Data?,_ error: Error?) -> Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get(url: URL, completionHandler: @escaping completeClosure) {
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSession.DataTaskResult) -> URLSessionDataTaskProtocol {
        // Returns the same data back this comes into play when we start testing these cases --> Passing in the same comple-tion handler of data
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}



