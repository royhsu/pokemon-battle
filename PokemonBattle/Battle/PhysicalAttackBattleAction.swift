//
//  PhysicalAttackBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PhysicalAttackBattleAction

import SpriteKit

public struct PhysicalAttackBattleAction: BattleAction {
    
    // MARK: Property
    
    public let attackPoint: Double
    
    public let battleFieldScene: BattleFieldScene?
    
    // MARK: BattleAction
    
    public func apply(on battlePokemon: BattlePokemon) -> BattlePokemon {
        
        var updatedBattlePokemon = battlePokemon
        
        updatedBattlePokemon.remainingHealthPoint -= attackPoint
        
        return updatedBattlePokemon
        
    }
    
    public func animateBattlePokemon(
        from oldValue: BattlePokemon,
        to newValue: BattlePokemon,
        completion: @escaping () -> Void
    ) {
        
        guard
            let battleFieldScene = battleFieldScene
        else {
            
            completion()
            
            return
            
        }
        
        if oldValue.id == "home" {
            
            battleFieldScene
                .homePokemonSpriteNode
                .run(
                    .sequence(
                        [
                            .fadeOut(withDuration: 0.2),
                            .fadeIn(withDuration: 0.2),
                            .fadeOut(withDuration: 0.2),
                            .fadeIn(withDuration: 0.2),
                            .fadeOut(withDuration: 0.2),
                            .fadeIn(withDuration: 0.2)
                        ]
                    ),
                    completion: completion
                )
            
        }
        else if oldValue.id == "guest" {
            
            battleFieldScene
                .guestPokemonSpriteNode
                .run(
                    .sequence(
                        [
                            .fadeOut(withDuration: 0.2),
                            .fadeIn(withDuration: 0.2),
                            .fadeOut(withDuration: 0.2),
                            .fadeIn(withDuration: 0.2),
                            .fadeOut(withDuration: 0.2),
                            .fadeIn(withDuration: 0.2)
                        ]
                    ),
                    completion: completion
                )
            
        }
        else { completion() }
        
    }
    
}
