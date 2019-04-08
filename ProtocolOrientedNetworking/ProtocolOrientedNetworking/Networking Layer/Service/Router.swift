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
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
        }
            
        catch {
            
        }
        
    }
    
    func cancel() {
        
    }
    
    
    fileprivate class func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod
        
        do {
            switch (route.task) {  // Depending on the additional configurations being sent with the request
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configute
                
            case .requestParametersandHeaders(let bodyParameters, let urlParameters, let headers):
                
            }
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        }
        catch {
            throw error
        }
    }
    
}
