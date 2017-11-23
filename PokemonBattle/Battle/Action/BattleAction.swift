//
//  BattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleAction

public protocol BattleAction {
    
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
