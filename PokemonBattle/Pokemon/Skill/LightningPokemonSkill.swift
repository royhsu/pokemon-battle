//
//  LightningPokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningPokemonSkill

public struct LightningPokemonSkill: PokemonSkill {
    
    // MARK: Property
    
    public static let name = "Lightning"
    
    public static let battleActionType: BattleAction.Type = LightningBattleAction.self
    
}
