//
//  BattleDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleAction

public protocol BattleAction { }

// MARK: - BattleDelegate

public protocol BattleDelegate: class {
    
    func addBattleAction(
        _ action: BattleAction,
        toPokemonWithIdentifier identifier: String
    )
    throws
    
    func performAllBattleActions()
    
}
