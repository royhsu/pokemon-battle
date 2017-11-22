//
//  BattleDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleDelegate

public protocol BattleDelegate: class {
    
    var battlePokemonDataProvider: BattlePokemonDataProvider? { get set }
    
    func addBattleAction(
        _ action: BattleAction,
        targetBattlePokemonId id: String
    )

    // If a performing action can't find the target battle pokemon with the given identifier, this action should be skipped.
    func performAllBattleActions()
    
}
