//
//  LightningBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningBattleAction

import SpriteKit

public struct LightningBattleAction: BattleAction {
    
    // MARK: Property
    
    public let magicPowerPoint: Double
    
    public weak var battleFieldScene: BattleFieldScene?
    
    // MARK: Init
    
    public init(
        pokemon: Pokemon,
        battleFieldScene: BattleFieldScene?
    ) {
        
        self.magicPowerPoint = pokemon.magicPowerPoint
        
        self.battleFieldScene = battleFieldScene
        
    }
    
    // MARK: BattleAction
    
    public func apply(on battlePokemon: BattlePokemon) -> BattlePokemon {
        
        var updatedBattlePokemon = battlePokemon
        
        updatedBattlePokemon.remainingHealthPoint -= magicPowerPoint * 1.2
        
        return updatedBattlePokemon
        
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
        
        let lightningEmitterSpriteNode = SKEmitterNode(fileNamed: "Lightning.sks")!
        
        lightningEmitterSpriteNode.position = targetPokemonSpriteNode?.position ?? .zero
        
        battleFieldScene?.addChild(lightningEmitterSpriteNode)
        
        targetPokemonSpriteNode?.run(
            .playSoundFileNamed(
                "ThunderShock.wav",
                waitForCompletion: false
            )
        )
        
        targetPokemonSpriteNode?.run(
            .sequence(
                [
                    .wait(
                        forDuration: 1.2
                    ),
                    .run { lightningEmitterSpriteNode.removeFromParent() },
                    .fadeOut(withDuration: 0.4),
                    .fadeIn(withDuration: 0.4)
                ]
            ),
            completion: completion
        )
        
    }
        
}
