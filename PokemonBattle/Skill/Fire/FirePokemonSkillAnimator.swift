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
            animation: { _, new, completion in
                
                let destinationId = context.destinationId
                
                let destinationSprite = context.destinationSprite
                
                let destinationHPLabel = context.destinationHPLabel
                
                let fireEmitter = SKEmitterNode(fileNamed: "Fire.sks")!
                
                fireEmitter.position = destinationSprite.anchorPoint
                
                destinationSprite.addChild(fireEmitter)
                
                destinationSprite.run(
                    .playSoundFileNamed(
                        "Fire.wav",
                        waitForCompletion: false
                    )
                )
                
                destinationSprite.run(
                    .sequence(
                        [
                            .wait(
                                forDuration: 1.5
                            ),
                            .run { fireEmitter.removeFromParent() },
                            .run {
                                
                                let battlePokemon = new.storage[destinationId]!
                                
                                destinationHPLabel.text = "HP: \(battlePokemon.remainingHealth)"
                                
                            },
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
