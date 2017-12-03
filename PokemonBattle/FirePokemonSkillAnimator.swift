//
//  FirePokemonSkillAnimator.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - FirePokemonSkillAnimator

import SpriteKit
import TinyBattleKit

public extension PokemonSkillAnimator {
    
    public static func fire(context: Context) -> PokemonSkillAnimator {
        
        return PokemonSkillAnimator(
            context: context,
            animation: { _, _, completion in
                
                let destinationNode = context.destinationNode
                
                let fireNode = SKEmitterNode(fileNamed: "Fire.sks")!
                
                fireNode.position = destinationNode.anchorPoint
                
                destinationNode.addChild(fireNode)
                
                destinationNode.run(
                    .playSoundFileNamed(
                        "FireBlast.wav",
                        waitForCompletion: false
                    )
                )
                
                destinationNode.run(
                    .sequence(
                        [
                            .wait(
                                forDuration: 1.5
                            ),
                            .run { fireNode.removeFromParent() },
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
