//
//  LightningSkillAnimator.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningSkillAnimator

import SpriteKit
import TinyBattleKit

public extension PokemonSkillAnimator {
    
    public typealias Animator = PokemonSkillAnimator
    
    public static func lightning(context: Context) -> Animator {
        
        return Animator(
            context: context,
            animation: { _, _, completion in
                
                let destinationNode = context.destinationNode
                
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
                    ),
                    completion: completion
                )
                
            }
        )
        
    }
    
}
