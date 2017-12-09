//
//  PokemonBattleContext.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleContext

import TinyBattleKit

public struct PokemonBattleContext: BattleResult {
    
    public typealias BattlePlayerID = String
    
    public typealias Storage = [BattlePlayerID: [BattlePokemon]]
    
    // MARK: Property
    
    // Todo: use [BattlePlayerID: BattlePokemon] to support multiple pokemons for a player.
    public var storage: Storage
    
    // MARK: Init
    
    public init(
        storage: Storage
    ) { self.storage = storage }
    
}
