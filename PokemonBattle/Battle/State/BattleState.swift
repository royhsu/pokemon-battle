//
//  BattleState.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleState

public enum BattleState {
    
    // MARK: Case
    
    case start, preparing, fighting, result(LegacyBattleResult), end
    
}
