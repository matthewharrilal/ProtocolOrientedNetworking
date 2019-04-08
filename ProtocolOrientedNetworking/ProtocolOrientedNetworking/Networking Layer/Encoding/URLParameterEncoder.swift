//
//  URLParameterEncoder.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/7/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    // Accepting request as a reference therefore changes will be made to the objects original spot in memory
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else {throw NetworkError.missingURL} // Throw error if url is missing
        
        // Only if there are parameters to concatenate 
        if  !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]() // Queuries contained on the url
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            // Update the url with the query items attached to the URL
            urlRequest.url = urlComponents.url
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
        }
    }
    
}
