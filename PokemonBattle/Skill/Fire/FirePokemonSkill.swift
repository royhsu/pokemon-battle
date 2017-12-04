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
    
    public typealias Provider = FirePokemonSkillProvider
    
    // MARK: Property
    
    public let name = NSLocalizedString(
        "Fire",
        comment: ""
    )
    
}
