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
        
        var attackingPokemonSpriteNode: SKSpriteNode?
        
        var targetPokemonSpriteNode: SKSpriteNode?
        
        var offsetX: CGFloat = 0.0
        
        if oldValue.id == BattleField.homeName {
            
            attackingPokemonSpriteNode = battleFieldScene.guestPokemonSpriteNode
            
            targetPokemonSpriteNode = battleFieldScene.homePokemonSpriteNode
            
            offsetX -= 15.0
            
        }
        else if oldValue.id == BattleField.guestName {
            
            attackingPokemonSpriteNode = battleFieldScene.homePokemonSpriteNode
            
            targetPokemonSpriteNode = battleFieldScene.guestPokemonSpriteNode
            
            offsetX += 15.0
            
        }
        else {
            
            completion()
            
            return
            
        }
        
        attackingPokemonSpriteNode?.run(
            .sequence(
                [
                    .moveBy(
                        x: offsetX,
                        y: 0.0,
                        duration: 0.3
                    ),
                    .moveBy(
                        x: -offsetX,
                        y: 0.0,
                        duration: 0.3
                    )
                ]
            )
        )
       
        targetPokemonSpriteNode?.run(
            .sequence(
                [
                    .wait(forDuration: 0.2),
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
    
}
