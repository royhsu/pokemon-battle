//
//  PhysicalAttackPokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PhysicalAttackPokemonSkill

public struct PhysicalAttackPokemonSkill: PokemonSkill {
    
    // MARK: Property
    
    public static let name = "Physical Attack"
    
    public static let battleActionType: BattleAction.Type = PhysicalAttackBattleAction.self
    
}
