//
//  BattleDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleDelegate

public protocol BattleDelegate: class {
    
    var battlePokemons: [BattlePokemon] { get set }
    
    func addBattleAction(
        _ action: BattleAction,
        toPokemonWithIdentifier identifier: String
    )
    throws
    
    func performAllBattleActions()
    
}
