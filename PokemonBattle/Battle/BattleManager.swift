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
    
    case battlePokemonDataPrivderNotFound
    
}

// MARK: - BattleManagerDelegate

public protocol BattleManagerDelegate: class {
    
    func battleManager(
        _  battleManager: BattleManager,
        didApply battleAction: BattleAction,
        on oldBattlePokemon: BattlePokemon,
        resultIn newBattlePokemon: BattlePokemon
    )
    
    func battleManager(
        _ battleManager: BattleManager,
        didFailWith error: Error
    )
    
}

// MARK: - BattleManager

public final class BattleManager: BattleDelegate {
    
    // MARK: Property
    
    internal typealias Action = (battlePokemonId: String, battleAction: BattleAction)
    
    internal final var actions: [Action] = []
    
    public final weak var battlePokemonDataProvider: BattlePokemonDataProvider?
    
    public final weak var battleManagerDelegate: BattleManagerDelegate?
    
    // MARK: BattleDelegate
    
    public func addBattleAction(
        _ action: BattleAction,
        targetBattlePokemonId id: String
    ) {
        
        actions.append(
            Action(
                battlePokemonId: id,
                battleAction: action
            )
        )
        
    }
    
    public final func performAllBattleActions() {
        
        guard
            let battlePokemonDataProvider = battlePokemonDataProvider
        else {
            
            battleManagerDelegate?.battleManager(
                self,
                didFailWith: BattleManagerError.battlePokemonDataPrivderNotFound
            )
            
            return
            
        }
        
        if actions.isEmpty { return }
        
        let action = actions.removeFirst()
        
        if let targetBattlePokemon = battlePokemonDataProvider.battlePokemon(id: action.battlePokemonId) {
            
            let updatedBattlePokemon = action.battleAction.apply(on: targetBattlePokemon)
            
            battlePokemonDataProvider.replaceBattlePokemon(
                id: action.battlePokemonId,
                with: updatedBattlePokemon
            )
            
            battleManagerDelegate?.battleManager(
                self,
                didApply: action.battleAction,
                on: targetBattlePokemon,
                resultIn: updatedBattlePokemon
            )
            
        }
        
        performAllBattleActions()
        
    }
    
}
