//
//  NetworkRouter.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

// Alias for our completion handler that is going to return a callback
public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()


// Protocol can only be conformed to other class objects
protocol NetworkRouter: class {
    associatedtype EndPoint: EndpointType // Our endpoint type can be composed of different types therefore we are making the attribute generic
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    
    func cancel()
}
