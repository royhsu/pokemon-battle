//
//  PokemonBattleContextError.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleContextError

public enum PokemonBattleContextError: Error {
    
    // MARK: Case
    
    case duplicateBattlePokemon(id: String)
    
}
