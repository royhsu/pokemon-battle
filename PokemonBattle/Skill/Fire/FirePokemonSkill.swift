//
//  FirePokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - FirePokemonSkill

import TinyBattleKit

public struct FirePokemonSkill: PokemonSkill {
    
    // MARK: Property
    
    public let name = NSLocalizedString(
        "Fire",
        comment: ""
    )
    
    // MARK: PokemonSkill
    
    public func makeProvider(
        id: String,
        priority: Double,
        sourceId: String,
        destinationIds: [String],
        context: Animator.Context
    )
    -> AnyBattleActionProvider<Animator> {
            
        let provider = FirePokemonSkillProvider(
            id: id,
            priority: priority,
            sourceId: sourceId,
            destinationIds: destinationIds,
            context: context
        )
        
        return AnyBattleActionProvider(provider)
            
    }
    
}
