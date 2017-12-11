//
//  PokemonBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 09/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattlePlayer

import TinyBattleKit

public struct PokemonBattleAction: BattleAction {
    
    // MARK: Property
    
    public let id: String
    
    public let skill: PokemonSkill
    
    public let priority: Double
    
    public let source: BattleEntity
    
    public let destinations: [BattleEntity]
    
    // MARK: Init
    
    public init(
        id: String,
        skill: PokemonSkill,
        priority: Double,
        source: BattleEntity,
        destinations: [BattleEntity]
    ) {
        
        self.id = id
        
        self.skill = skill
        
        self.priority = priority
        
        self.source = source
        
        self.destinations = destinations
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleAction {
    
    public init(_ action: BattleActionRealmObject) {
        
        self.init(
            id: action.id!,
            skill: PokemonSkill(action.skill!),
            priority: action.priority,
            source: BattlePokemon(action.source!),
            destinations: action.destinations.map(BattlePokemon.init)
        )
        
    }
    
}
