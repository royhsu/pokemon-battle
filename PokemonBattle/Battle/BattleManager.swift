//
//  BattleManager.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleManagerError

public enum BattleManagerError: Error {
    
    // MARK: Case
    
    case battlePokemonNotFound(identifier: String)
    
}

// MARK: - BattleManager

public final class BattleManager: BattleDelegate {
    
    // MARK: Property
    
    internal final var battleMap: [String: Array<BattleAction>] = [:]
    
    public final var battlePokemons: [BattlePokemon] = []
    
    // MARK: BattleDelegate
    
    public final func addBattleAction(
        _ action: BattleAction,
        toPokemonWithIdentifier identifier: String
    )
    throws {
        
        let isExisting = battlePokemons.contains { $0.identifier == identifier }
        
        if !isExisting {
            
            throw BattleManagerError.battlePokemonNotFound(identifier: identifier)
            
        }
        
        var actions = battleMap[identifier] ?? []
        
        actions.append(action)
        
        battleMap[identifier] = actions
        
    }
    
    public final func performAllBattleActions() {
        
        for index in 0..<battlePokemons.count {
            
            let battlePokemon = battlePokemons[index]
            
            let identifier = battlePokemon.identifier
            
            guard
                let actions = battleMap.removeValue(forKey: identifier)
            else { continue }
            
            let updatedBattlePokemon: BattlePokemon = actions.reduce(battlePokemon) { currentBattlePokemon, action in
                
                let nextBattlePokemon = action.applied(battlePokemon: currentBattlePokemon)
                
                return nextBattlePokemon
                
            }
            
            battlePokemons[index] = updatedBattlePokemon
            
        }
        
    }
    
}
