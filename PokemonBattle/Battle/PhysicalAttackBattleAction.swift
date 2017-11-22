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
    
    // MARK: BattleAction
    
    public func apply(on battlePokemon: BattlePokemon) -> BattlePokemon {
        
        var updatedBattlePokemon = battlePokemon
        
        updatedBattlePokemon.healthPoint -= attackPoint
        
        return updatedBattlePokemon
        
    }
    
}
