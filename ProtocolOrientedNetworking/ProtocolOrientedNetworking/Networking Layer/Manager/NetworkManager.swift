//
//  NetworkManager.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation


public struct NetworkManager {
    let router = Router<PokeAPI>() // Router configured to handle PokeAPI response
}


public enum NetworkResponse: String {
    case success = "Network call was a success"
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "The network call resulted in a failure"
    case noData = "The network call resulted in no data being sent back"
    case unableToDecode = "Unable to decode the response"
}

public enum Result<String> {
    case success(String)
    case failure(String)
}


fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
    switch response.statusCode {
    case 200 ... 299:
        return .success(NetworkResponse.success.rawValue)
    case 401 ... 500:
        return .failure(NetworkResponse.authenticationError.rawValue)
    case 501 ... 599:
        return .failure(NetworkResponse.badRequest.rawValue)
    case 600:
        return .failure(NetworkResponse.outdated.rawValue)
    default:
        return .failure(NetworkResponse.failed.rawValue)
        
    }
}
