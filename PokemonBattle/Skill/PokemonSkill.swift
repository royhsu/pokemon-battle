//
//  PokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkill

import TinyBattleKit

public enum PokemonSkill: String {
    
    // MARK: Case
    
    case lightning = "LIGHTNING"
    
    case fire = "FIRE"
    
    // MARK: Property
    
    public var name: String { return rawValue }
    
    // MARK: Provider
    
    func makeProvider(
        id: String,
        priority: Double,
        sourceId: String,
        destinationIds: [String],
        context: PokemonSkillAnimator.Context
    )
    -> AnyBattleActionProvider<PokemonSkillAnimator> {
        
        switch self {
            
        case .lightning:
            
            let provider = LightningPokemonSkillProvider(
                id: id,
                priority: priority,
                sourceId: sourceId,
                destinationIds: destinationIds,
                context: context
            )
            
            return AnyBattleActionProvider(provider)
            
        case .fire:
            
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
    
}

// MARK: - Realm

public extension PokemonSkill {
    
    public init(_ skill: BattleSkillRealmObject) {
        
        self.init(rawValue: skill.name!)!
        
    }
    
}
