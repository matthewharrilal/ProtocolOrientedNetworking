//
//  Pokemon.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/8/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

//struct Pokemon {
//    var height: Int
//    var baseExperience: Int
//
//    init(height: Int, baseExperience: Int) {
//        self.height = height
//        self.baseExperience = baseExperience
//    }
//}
//
//extension Pokemon: Decodable {
//    private enum PokemonKeys: String, CodingKey {
//        case height
//        case baseExperience = "base_experience"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: PokemonKeys.self)
//
//        let height = try container.decodeIfPresent(Int.self, forKey: .height) ?? 0
//        let baseExperience = try container.decodeIfPresent(Int.self, forKey: .baseExperience) ?? 0
//        self.init(height: height, baseExperience: baseExperience)
//    }
//}

struct Pokemon {
    var abilities: [Abilities]
    var baseExperience: Int
    var forms: [Form]
    var height: Int
    
    init(abilities: [Abilities], baseExperience: Int, forms: [Form], height: Int) {
        self.abilities = abilities
        self.baseExperience = baseExperience
        self.forms = forms
        self.height = height
    }

}


struct Abilities {
    var ability: Ability
    var isHidden: Bool
    var slot: Int
    
    init(ability: Ability, isHidden: Bool, slot: Int) {
        self.ability = ability
        self.isHidden = isHidden
        self.slot = slot
    }
}

extension Abilities: Decodable {
    private enum AbilitiesKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbilitiesKeys.self)
        let ability = try container.decode(Ability.self, forKey: .ability)
        let isHidden = try container.decode(Bool.self, forKey: .isHidden)
        let slot = try container.decode(Int.self, forKey: .slot)
        self.init(ability: ability, isHidden: isHidden, slot: slot)
    }
}

struct Form {
    var forms: [Ability]

    init(forms: [Ability]) {
        self.forms = forms
    }
}

extension Form: Decodable {
    private enum FormKeys: String, CodingKey {
        case forms = "forms"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FormKeys.self)
        // Overwriting stored properties
        let forms = try container.decodeIfPresent([Ability].self, forKey: .forms) ?? []
        
        self.init(forms: forms)
    }
}

struct Ability {
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

extension Ability: Decodable {
    private enum AbilityKeys: String, CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AbilityKeys.self)
        
        // Overwriting stored properties
        let name = try container.decodeIfPresent(String.self, forKey: .name) ?? "No Name"
        let url = try container.decodeIfPresent(String.self, forKey: .url) ?? "No url given"
        self.init(name: name, url: url)
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
        let abilities = try container.decodeIfPresent([Abilities].self, forKey: .abilities) ?? []
        let baseExperience = try container.decodeIfPresent(Int.self, forKey: .baseExperience) ?? 0
        let forms = try container.decodeIfPresent([Form].self, forKey: .forms) ?? []
        let height = try container.decodeIfPresent(Int.self, forKey: .height) ?? 0

        // Top level structure not being referenced therefore need to initialize
        self.init(abilities: abilities, baseExperience: baseExperience, forms: forms, height: height)
    }
}
