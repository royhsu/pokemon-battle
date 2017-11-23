//
//  WaggingTailBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - WaggingTailBattleAction

import SpriteKit

public struct WaggingTailBattleAction: BattleAction {
    
    // MARK: Property
    
    public let battleFieldScene: BattleFieldScene?
    
    // MARK: Init
    
    public init(
        pokemon: Pokemon,
        battleFieldScene: BattleFieldScene?
    ) {
        
        self.battleFieldScene = battleFieldScene
        
    }
    
    // MARK: BattleAction
    
    public func apply(on battlePokemon: BattlePokemon) -> BattlePokemon {
        
        return battlePokemon
        
    }
    
    public func animateBattlePokemon(
        from oldValue: BattlePokemon,
        to newValue: BattlePokemon,
        completion: @escaping () -> Void
        ) {
        
        var attackingPokemonSpriteNode: SKSpriteNode?
        
        var targetPokemonSpriteNode: SKSpriteNode?
        
        if oldValue.id == BattleField.homeName {
            
            attackingPokemonSpriteNode = battleFieldScene?.guestPokemonSpriteNode
            
            targetPokemonSpriteNode = battleFieldScene?.homePokemonSpriteNode
            
        }
        else if oldValue.id == BattleField.guestName {
            
            attackingPokemonSpriteNode = battleFieldScene?.homePokemonSpriteNode
            
            targetPokemonSpriteNode = battleFieldScene?.guestPokemonSpriteNode
            
        }
        
        if
            battleFieldScene == nil
            || attackingPokemonSpriteNode == nil
            || targetPokemonSpriteNode == nil {
            
            completion()
            
            return
            
        }
        
        attackingPokemonSpriteNode?.run(
            .playSoundFileNamed(
                "TailWhip.wav",
                waitForCompletion: false
            )
        )
        
        attackingPokemonSpriteNode?.run(
            .sequence(
                [
                    .moveBy(
                        x: 10.0, y: 0.0,
                        duration: 0.1
                    ),
                    .moveBy(
                        x: -20.0, y: 0.0,
                        duration: 0.2
                    ),
                    .moveBy(
                        x: 20.0, y: 0.0,
                        duration: 0.2
                    ),
                    .moveBy(
                        x: -10.0, y: 0.0,
                        duration: 0.1
                    ),
                    .wait(forDuration: 0.4)
                ]
            )
        )
        
        targetPokemonSpriteNode?.run(
            .sequence(
                [
                    .wait(forDuration: 0.8),
                    .playSoundFileNamed(
                        "PoisonPowder.wav",
                        waitForCompletion: false
                    )
                ]
            )
        )
        
        targetPokemonSpriteNode?.run(
            .sequence(
                [
                    .wait(forDuration: 0.8),
                    .fadeAlpha(
                        to: 0.5,
                        duration: 0.5
                    ),
                    .fadeAlpha(
                        to: 1.0,
                        duration: 0.5
                    ),
                    .wait(forDuration: 1.0)
                ]
            ),
            completion: completion
        )
        
    }
    
}
