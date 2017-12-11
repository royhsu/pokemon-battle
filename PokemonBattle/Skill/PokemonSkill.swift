//
//  PokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkill

import TinyBattleKit

public struct PokemonSkill {
    
    // MARK: Property
    
    public let name: String
    
    // MARK: Init
    
    public init(name: String) { self.name = name }
    
//    func makeProvider(
//        priority: Double,
//        sourceId: String,
//        destinationIds: [String],
//        context: PokemonSkillAnimator.Context
//    )
//    -> AnyBattleActionProvider<PokemonSkillAnimator>
    
}

// MARK: - Realm

public extension PokemonSkill {
    
    public init(_ skill: BattleSkillRealmObject) {
        
        self.init(name: skill.name!)
        
    }
    
}
