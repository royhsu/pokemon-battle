//
//  FirePokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - FirePokemonSkill

import Foundation

public struct FirePokemonSkill: PokemonSkill {
    
    // MARK: Property
    
    public let name = NSLocalizedString(
        "Fire",
        comment: ""
    )
    
    public let providerType = FirePokemonSkillProvider.self
    
}
