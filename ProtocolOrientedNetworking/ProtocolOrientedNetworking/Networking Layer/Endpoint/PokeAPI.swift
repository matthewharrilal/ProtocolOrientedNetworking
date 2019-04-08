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
    
    case delete = ""
}


extension PokeAPI: EndpointType {
    var baseUrl: URL {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {fatalError("Base url could not be configured")}
        return url
    }
    
    var path: String {
        switch self {
            
        // Path will be appended when we are constructing the request
        case .pokemonName(let name):
            return "\(name)"
        }
    }
    
    var httpMethod: String {
        return HTTPMethods.get.rawValue
    }
    
    var task: HTTPTask {
        // This request contains no parameters or query items ... configurations are apart of pathway
        return .request
    }
        
}
