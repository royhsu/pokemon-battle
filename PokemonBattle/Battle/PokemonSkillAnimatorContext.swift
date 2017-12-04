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
    
    public let sourceId: String
    
    public unowned let sourceSprite: SKSpriteNode
    
    public unowned let sourceHPLabel: SKLabelNode
    
    public let destinationId: String
    
    public unowned let destinationSprite: SKSpriteNode
    
    public unowned let destinationHPLabel: SKLabelNode
    
    // MARK: Init
    
    public init(
        sourceId: String,
        sourceSprite: SKSpriteNode,
        sourceHPLabel: SKLabelNode,
        destinationId: String,
        destinationSprite: SKSpriteNode,
        destinationHPLabel: SKLabelNode
    ) {
        
        self.sourceId = sourceId
        
        self.sourceSprite = sourceSprite
        
        self.sourceHPLabel = sourceHPLabel
        
        self.destinationId = destinationId
        
        self.destinationSprite = destinationSprite
        
        self.destinationHPLabel = destinationHPLabel
        
    }
    
}

