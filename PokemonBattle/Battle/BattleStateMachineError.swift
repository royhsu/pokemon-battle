//
//  BattleStateMachineError.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleStateMachineError

public enum BattleStateMachineError: Error {
    
    // MARK: Case
    
    case invalidTransition(
        from: BattleState,
        to: BattleState
    )
    
}
