//
//  FireBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - FireBattleAction

import SpriteKit

public struct FireBattleAction: BattleAction {
    
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
        
        updatedBattlePokemon.remainingHealthPoint -= magicPowerPoint * 1.1
        
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
        
        let fireEmitterSpriteNode = SKEmitterNode(fileNamed: "Fire.sks")!
        
        fireEmitterSpriteNode.position = targetPokemonSpriteNode?.position ?? .zero
        
        battleFieldScene?.addChild(fireEmitterSpriteNode)
        
        targetPokemonSpriteNode?.run(
            .playSoundFileNamed(
                "FireBlast.wav",
                waitForCompletion: false
            )
        )
        
        targetPokemonSpriteNode?.run(
            .sequence(
                [
                    .wait(
                        forDuration: 1.5
                    ),
                    .run { fireEmitterSpriteNode.removeFromParent() },
                    .fadeOut(withDuration: 0.4),
                    .fadeIn(withDuration: 0.4)
                ]
            ),
            completion: completion
        )
        
    }
    
}
