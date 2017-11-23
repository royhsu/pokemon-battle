//
//  WaggingTailPokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - WaggingTailPokemonSkill

public struct WaggingTailPokemonSkill: PokemonSkill {
    
    // MARK: Property
    
    public static let name = "Wagging Tail"
    
    public static let battleActionType: BattleAction.Type = WaggingTailBattleAction.self
    
}
