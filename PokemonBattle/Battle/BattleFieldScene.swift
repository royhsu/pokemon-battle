//
//  BattleFieldScene.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleFieldSceneDataProvider

public protocol BattleFieldSceneDataProvider: class {
    
    var homePokemonSpriteNode: SKSpriteNode { get }
    
    var guestPokemonSpriteNode: SKSpriteNode { get }
    
}

// MARK: - BattleFieldScene

import SpriteKit

public final class BattleFieldScene: SKScene {
    
    // MARK: Property
    
    public final weak var sceneDataProvider: BattleFieldSceneDataProvider?
    
    public final var homePokemonSpriteNode: SKSpriteNode?
    
    public final var guestPokemonSpriteNode: SKSpriteNode?
    
    // MARK: Life Cycle
    
    public final override func didMove(to view: SKView) {
        
        
        
    }
    
    public final func updateData() {
        
        homePokemonSpriteNode?.removeFromParent()
        
        guestPokemonSpriteNode?.removeFromParent()
        
        guard
            let sceneDataProvider = sceneDataProvider
        else { return }
        
        let homeSpriteNode = sceneDataProvider.homePokemonSpriteNode

        addChild(homeSpriteNode)
        
        setUpHomePokemonSpriteNode(homeSpriteNode)

        let guestSpriteNode = sceneDataProvider.guestPokemonSpriteNode
        
        addChild(guestSpriteNode)
        
        setUpGuestPokemonSpriteNode(guestSpriteNode)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpHomePokemonSpriteNode(_ spriteNode: SKSpriteNode) {
        
        spriteNode.position = CGPoint(
            x: 100.0 + frame.minX,
            y: 100.0 + frame.minY
        )
        
    }
    
    fileprivate final func setUpGuestPokemonSpriteNode(_ spriteNode: SKSpriteNode) {
        
        spriteNode.position = CGPoint(
            x: frame.maxX - 100.0,
            y: frame.maxY - 100.0
        )
        
    }
 
}
