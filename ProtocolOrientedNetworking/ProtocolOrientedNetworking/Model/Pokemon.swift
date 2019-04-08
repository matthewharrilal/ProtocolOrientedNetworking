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


struct Abilities {
    var ability: Ability
    var isHidden: Bool
    var slot: Int
}

struct Form {
    var form: [Ability]
}

struct Ability {
    var name: String
    var url: String
}
