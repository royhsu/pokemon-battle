//
//  BattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleAction

public protocol BattleAction {
    
    // You should declare battle field scene as weak property in order to avoid retain cycle.
    init(
        pokemon: Pokemon,
        battleFieldScene: BattleFieldScene?
    )

    func apply(on battlePokemon: BattlePokemon) -> BattlePokemon
    
    func animateBattlePokemon(
        from oldValue: BattlePokemon,
        to newValue: BattlePokemon,
        completion: @escaping () -> Void
    )
    
}
