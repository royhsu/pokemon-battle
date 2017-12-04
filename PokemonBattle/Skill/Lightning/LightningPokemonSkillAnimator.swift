//
//  LightningPokemonSkillAnimator.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningPokemonSkillAnimator

import SpriteKit
import TinyBattleKit

public extension PokemonSkillAnimator {
    
    public static func lightning(context: Context) -> PokemonSkillAnimator {
        
        return PokemonSkillAnimator(
            context: context,
            animation: { _, _, completion in
                
                let destinationNode = context.destinationNode
                
                let lightningNode = SKEmitterNode(fileNamed: "Lightning.sks")!
                
                lightningNode.position = destinationNode.anchorPoint
                
                destinationNode.addChild(lightningNode)
                
                destinationNode.run(
                    .playSoundFileNamed(
                        "Lightning.wav",
                        waitForCompletion: false
                    )
                )
                
                destinationNode.run(
                    .sequence(
                        [
                            .wait(
                                forDuration: 1.2
                            ),
                            .run { lightningNode.removeFromParent() },
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
