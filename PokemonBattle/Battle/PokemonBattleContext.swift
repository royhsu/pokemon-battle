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
    
    // MARK: Property
    
    private var battlePokemonMap: [String: BattlePokemon] = [:]
    
    // MARK: Init
    
    public init(battlePokemons: [BattlePokemon]) throws {
        
        try battlePokemons.forEach { battlePokemon in
            
            let battlePokemonId = battlePokemon.id
            
            guard
                battlePokemonMap[battlePokemonId] == nil
            else {
                
                let error: PokemonBattleContextError = .duplicateBattlePokemon(id: battlePokemonId)
                
                throw error
                
            }
            
            battlePokemonMap[battlePokemonId] = battlePokemon
            
        }
        
    }
    
}

// MARK: - PokemonBattle

public extension PokemonBattleContext {
    
    public func battlePokemon(id: String) -> BattlePokemon? { return battlePokemonMap[id] }
    
    public mutating func replaceBattlePokemon(with newValue: BattlePokemon) {
        
        let battlePokemonId = newValue.id
        
        if battlePokemonMap[battlePokemonId] == nil {
            
            fatalError("Battle pokemon not found with the given id.")
            
        }
        
        battlePokemonMap[battlePokemonId] = newValue
        
    }
    
}
