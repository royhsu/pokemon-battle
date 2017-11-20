//
//  BattleStartScene.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleStartScene

import SpriteKit

public final class BattleStartScene: SKScene {
    
    // NARK: Property
    
    public final var titleLabel: SKLabelNode {
        
        return childNode(withName: "//titleLabel") as! SKLabelNode
    
    }
    
    // MARK: Life Cycle
    
    public final override func didMove(to view: SKView) {
        
        titleLabel.text = "Battle!"
        
    }
    
}
