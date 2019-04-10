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
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

// Clarify why when your extension conforms to a protocol why it doesn't need to add the protocol stubs?
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL? // Used to mark that we made the request ... middleman between creation and execution
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping MockURLSession.DataTaskResult) -> URLSessionDataTaskProtocol {
        
        // Going to be set before this data task method is called therefore having data when being passed back up via the completion handler
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        
        return nextDataTask // Used purely for the reason of marking if the data task has been resumed thats why we dont return Void and instead return our dummy data task to mark whether or not the user has actually kicked off the network request
    }
    
}


class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var resumeWasCalled = false // Initially the task hasn't been kicked off yet
    
    func resume() {
        self.resumeWasCalled = true
    }
}
