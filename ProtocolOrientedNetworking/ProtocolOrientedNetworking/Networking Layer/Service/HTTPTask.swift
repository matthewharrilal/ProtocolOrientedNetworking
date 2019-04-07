//
//  HTTPTasl.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/7/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

public typealias HTTPHeaders =  [String: String]
public typealias Parameters = [String: Any]

public enum HTTPTask {
    case request // If the request needs no configuration
    
    // If request is comprised of a body and url parameters
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters)
    
    // If request is compromised of headers as well but may not be post requet --> opitionl!
    case requestParametersandHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, headers: HTTPHeaders?)
}

public protocol ParameterEncoder {
    
    // If passing request by reference have to make static so there is not multiple instantations ... cause for corruption and throws custom error of your choice
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    // For custom errors
    
    case parametersNil = "Missing parameters on request"
    
    case encodingFailed = "Failed to encode configurations"
    
    case missingURL = "Failed to provide a url"
}
