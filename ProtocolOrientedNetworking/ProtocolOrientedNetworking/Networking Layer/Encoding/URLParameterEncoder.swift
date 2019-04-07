//
//  URLParameterEncoder.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/7/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else {throw NetworkError.missingURL} // Throw error if url is missing
        
        if  !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]() // Queuries contained on the url
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
        }
    }
    
}
