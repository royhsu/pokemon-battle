//
//  PhysicalAttackBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PhysicalAttackBattleAction

public struct PhysicalAttackBattleAction: BattleAction {
    
    // MARK: BattleAction
    
    public func applied(battlePokemon: BattlePokemon) -> BattlePokemon {
        
        var updatedBattlePokemon = battlePokemon
        
        updatedBattlePokemon.healthPoint -= 10.0
        
        return updatedBattlePokemon
        
    }
    
}
