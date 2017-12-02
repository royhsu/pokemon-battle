//
//  LightningSkillProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningSkillProvider

import TinyBattleKit
import SpriteKit

public final class LightningSkillProvider: BattleActionProvider {
    
    public typealias Result = BattleContext
    
    // MARK: Property
    
    public final let priority = 100.0
    
    // Extra damage ratio
    public final let extra = 0.2
    
    // Todo: replace primetive type String with custom type PokemonID
    public final let sourceId: String
    
    // Todo: replace primetive type String with custom type PokemonID
    public final let destinationId: String
    
    public final unowned let sourceNode: SKSpriteNode
    
    public final unowned let destinationNode: SKSpriteNode
    
    // MARK: Init
    
    public init(
        sourceId: String,
        destinationId: String,
        sourceNode: SKSpriteNode,
        destinationNode: SKSpriteNode
    ) {
        
        self.sourceId = sourceId
        
        self.destinationId = destinationId
        
        self.sourceNode = sourceNode
        
        self.destinationNode = destinationNode
        
    }
    
    // MARK: BattleActionProvider
    
    public final func applyAction(on result: BattleContext) -> BattleContext {
        
        let source = result.entity(id: sourceId)!
        
        let destination = result.entity(id: destinationId)!
        
        let finalMagic = source.magic * (1.0 + extra)
        
        let damage = finalMagic - destination.magicResistance
        
        var updatedDestination = destination
        
        updatedDestination.remainingHealth -= damage
        
        var updatedResult = result
        
        updatedResult.replaceEntity(with: updatedDestination)
        
        animate(
            sourceNode: sourceNode,
            destinationNode: destinationNode
        )
    
        return updatedResult
        
    }
    
    public final func animate(
        sourceNode: SKSpriteNode,
        destinationNode: SKSpriteNode
    ) {
       
        let lightningEmitterNode = SKEmitterNode(fileNamed: "Lightning.sks")!
        
        lightningEmitterNode.position = destinationNode.anchorPoint
        
        destinationNode.addChild(lightningEmitterNode)
        
        destinationNode.run(
            .playSoundFileNamed(
                "ThunderShock.wav",
                waitForCompletion: false
            )
        )
        
        destinationNode.run(
            .sequence(
                [
                    .wait(
                        forDuration: 1.2
                    ),
                    .run { lightningEmitterNode.removeFromParent() },
                    .fadeOut(withDuration: 0.4),
                    .fadeIn(withDuration: 0.4)
                ]
            )
        )
        
    }
    
}

// MARK: Factory

public extension BattleActionProvider
where Self.Result == BattleContext {
    
    public static func lightningSkill(
        sourceId: String,
        destinationId: String,
        sourceNode: SKSpriteNode,
        destinationNode: SKSpriteNode
    )
    -> AnyBattleActionProvider<Result> {
        
        let provider = LightningSkillProvider(
            sourceId: sourceId,
            destinationId: destinationId,
            sourceNode: sourceNode,
            destinationNode: destinationNode
        )
        
        return AnyBattleActionProvider(provider)
        
    }
    
}
