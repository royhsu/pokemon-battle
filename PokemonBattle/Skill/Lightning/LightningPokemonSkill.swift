//
//  LightningPokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningPokemonSkill

import Foundation

public struct LightningPokemonSkill: PokemonSkill {
    
    public typealias Provider = LightningPokemonSkillProvider
    
    // MARK: Property
    
    public let name = NSLocalizedString(
        "Lightning",
        comment: ""
    )
    
}
