//
//  StubBattlePokemonDataProvider.swift
//  PokemonBattleTests
//
//  Created by Roy Hsu on 22/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - StubBattlePokemonDataProvider

import PokemonBattle

internal final class StubBattlePokemonDataProvider: BattlePokemonDataProvider {
    
    // MARK: Property
    
    internal final var stubBattlePokemons: [BattlePokemon]
    
    // MARK: Init
    
    internal init(stubBattlePokemons: [BattlePokemon]) {
        
        self.stubBattlePokemons = stubBattlePokemons
        
    }
    
    // MARK: BattlePokemonDataProvider
    
    internal final func replaceBattlePokemon(
        id: String,
        with newBattlePokemon: BattlePokemon
    ) {
        
        guard
            let index = stubBattlePokemons.index(
                where: { $0.id == id }
            )
        else { return }
        
        stubBattlePokemons[index] = newBattlePokemon
        
    }
    
    internal final func battlePokemon(id: String) -> BattlePokemon? {
        
        guard
            let index = stubBattlePokemons.index(
                where: { $0.id == id }
            )
        else { return nil }
        
        return stubBattlePokemons[index]
        
    }
    
}
