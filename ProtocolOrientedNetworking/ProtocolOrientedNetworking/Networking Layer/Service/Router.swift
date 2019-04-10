//
//  File.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

// Endpoint is of generic type --> type of class depends on type of endpoint ... Inherits it attributes from the Network Router

// Use this class to configure custom apis and the attributes corresponding to fetch results
class Router<EndPoint: EndpointType>: NetworkRouter {
    
    private var task: URLSessionTask?  // We do not want other files accessing our task
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            // In charge of adding configurations to the given request such as the parameters and the headers if need be
            let request = try self.buildRequest(from: route)
            
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        }
            
        catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        // Cancel the current network task if need be
        self.task?.cancel()
    }
    
    // When you denote a method as a class func it is a reference to the objects original spot in memory ... static
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        // In charge of configuring the request with the necessary parameters and configurations if need be
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod // Assign the HTTP method to the request
        
        do {
            switch (route.task) {  // Depending on the additional configurations being sent with the request
            case .request:
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
              
                
            case .requestParameters(let bodyParameters, let urlParameters):
                
                // In charge of configuring parameters on the request
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .requestParametersandHeaders(let bodyParameters, let urlParameters, let headers):
                self.addAdditionalHeaders(headers, request: &request) // Add headers to the request
                
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        }
        
        catch {
            throw error // When you want to return something against the concrete return type
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
    
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else {return}
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
