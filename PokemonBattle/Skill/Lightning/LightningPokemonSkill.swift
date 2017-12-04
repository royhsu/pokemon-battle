//
//  LightningPokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningPokemonSkill

import TinyBattleKit

public struct LightningPokemonSkill: PokemonSkill {
    
    // MARK: Property
    
    public let name = NSLocalizedString(
        "Lightning",
        comment: ""
    )
    
    // MARK: PokemonSkill
    
    public func makeSkillProvider(
        id: String,
        sourceId: String,
        destinationIds: [String],
        context: PokemonSkillAnimatorContext
    )
    -> AnyBattleActionProvider<PokemonSkillAnimator> {
            
        let provider = LightningPokemonSkillProvider(
            id: id,
            sourceId: sourceId,
            destinationIds: destinationIds,
            context: context
        )
        
        return AnyBattleActionProvider(provider)
        
    }
    
}
