//
//  NetworkManager.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

typealias PokemonData = (_ pokemon: Pokemon?, _ error: String?) -> ()

public struct NetworkManager {
    let router = Router<PokeAPI>() // Router configured to handle PokeAPI response with the neccessary components
}


// Some elegant enums used to be able to mark the status of the request at every step of the way such as the decoding process, the network request process, and others that you can see below
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

func getPokemon(name: String, completion: @escaping (_ pokemon: Pokemon?, _ error: String?) -> ()) {
    let networkManager = NetworkManager()
    networkManager.router.request(.pokemonName(name: name)) { (data, response, error) in
        if error != nil {
            completion(nil, "Please check network connection")
        }
        
        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response) // Based off the response output the appropriate response
            switch result {
            case .success:
                // If the request comes back successful
                guard let responseData = data else {
                    return completion(nil, NetworkResponse.noData.rawValue)
                }
                
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: responseData)
                    completion(pokemon, nil)
                }
                catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
                
            case .failure:
                completion(nil, NetworkResponse.failed.rawValue)
            }
        }
    }
}
