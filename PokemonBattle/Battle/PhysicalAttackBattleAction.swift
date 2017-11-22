//
//  PhysicalAttackBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PhysicalAttackBattleAction

public struct PhysicalAttackBattleAction: BattleAction {
    
    // MARK: Property
    
    public let attackPoint: Double
    
    public let animation: BattleActionAnimation?
    
    // MARK: BattleAction
    
    public func applied(battlePokemon: BattlePokemon) -> BattlePokemon {
        
        var updatedBattlePokemon = battlePokemon
        
        updatedBattlePokemon.healthPoint -= attackPoint
        
        animation?(battlePokemon, updatedBattlePokemon)
        
        return updatedBattlePokemon
        
    }
    
}
