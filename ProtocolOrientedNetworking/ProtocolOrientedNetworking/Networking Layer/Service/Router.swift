//
//  File.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

// Endpoint is of generic type --> type of class depends on type of endpoint
class Router<EndPoint: EndpointType>: NetworkRouter {
    private var task: URLSessionTask?  // We do not want other files accessing our task
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
    }
    
    func cancel() {
        <#code#>
    }
    
    
}
