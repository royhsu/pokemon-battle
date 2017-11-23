//
//  FirePokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - FirePokemonSkill

public struct FirePokemonSkill: PokemonSkill {
    
    // MARK: Property
    
    public static let name = "Fire"
    
    public static let battleActionType: BattleAction.Type = FireBattleAction.self
    
}
