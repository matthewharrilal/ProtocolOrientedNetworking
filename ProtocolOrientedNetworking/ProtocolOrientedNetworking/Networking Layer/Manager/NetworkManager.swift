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
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}
