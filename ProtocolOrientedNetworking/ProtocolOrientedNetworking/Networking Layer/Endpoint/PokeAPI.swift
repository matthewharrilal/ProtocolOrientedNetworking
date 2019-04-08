//
//  PokeAPI.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation


public enum PokeAPI {
    // Enum to contain endpoints
    case pokemonName(name: String)
}

public enum HTTPMethods: String {
    case get = "GET"
    
    case post = "POST"
    
    case delete = "DELETE"
}


extension PokeAPI: EndpointType {
    var baseUrl: URL {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    }
    
    var path: String {
        switch self {
            
        // Path will be appended when we are constructing the request
        case .pokemonName(let name):
            return "\(name)"
        }
    }
    
    var httpMethod: String {
        return "get" // Can make more dynamic
    }
    
    var task: HTTPTask {
        
    }
    
    // Extend our enum containing endpoints to configure the corresponding base url
    
}
