//
//  PokemonSkillAnimatorContext.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkillAnimatorContext

import SpriteKit
import TinyBattleKit

public struct PokemonSkillAnimatorContext: BattleActionAnimatorContext {
    
    // MARK: Property
    
    public unowned let sourceNode: SKSpriteNode
    
    public unowned let destinationNode: SKSpriteNode
    
    // MARK: Init
    
    public init(
        sourceNode: SKSpriteNode,
        destinationNode: SKSpriteNode
    ) {
        
        self.sourceNode = sourceNode
        
        self.destinationNode = destinationNode
        
    }
    
}

