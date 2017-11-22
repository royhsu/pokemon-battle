//
//  BattlePokemonDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 22/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattlePokemonDataProvider

public protocol BattlePokemonDataProvider: class {
    
    func replaceBattlePokemon(
        id: String,
        with newBattlePokemon: BattlePokemon
    )
    
    func battlePokemon(id: String) -> BattlePokemon?
    
}
