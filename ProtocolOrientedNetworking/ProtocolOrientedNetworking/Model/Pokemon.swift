//
//  Pokemon.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation


struct Pokemon {
    var abilities: [Abilities]
    var baseExperience: Int
    var forms: [Form]
    var height: Int
    
}


struct Abilities: Decodable {
    var ability: Ability
    var isHidden: Bool
    var slot: Int
    
    private enum AbilitiesKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Form: Decodable {
    var form: [Ability]
    
    private enum FormKeys: String, CodingKey {
        case form
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FormKeys.self)
        // Overwriting stored properties
        form = try container.decode([Ability].self, forKey: .form)
    }
}

struct Ability: Decodable {
    var name: String
    var url: String
    
    private enum AbilityKeys: String, CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbilityKeys.self)
        
        // Overwriting stored properties
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
    }
}


extension Pokemon: Decodable {
    private enum PokemonKeys: String, CodingKey {
        case abilities
        
        case baseExperience = "base_experience"
        
        case forms
        
        case height
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        let abilities = try container.decode([Abilities].self, forKey: .abilities)
        let baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        let forms = try container.decode([Form].self, forKey: .forms)
        let height = try container.decode(Int.self, forKey: .height)
        
        // Top level structure not being referenced therefore need to initialize
        self.init(abilities: abilities, baseExperience: baseExperience, forms: forms, height: height)
    }
}
