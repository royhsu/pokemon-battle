//
//  BattleFieldScene.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleFieldSceneDataProvider

public protocol BattleFieldSceneDataProvider: class {
    
    var homePokemon: Pokemon { get }
    
    var guestPokemon: Pokemon { get }
    
}

// MARK: - BattleFieldScene

import SpriteKit

public final class BattleFieldScene: SKScene {
    
    // MARK: Property
    
    public final weak var sceneDataProvider: BattleFieldSceneDataProvider?
    
    public final var homePokemonSpriteNode: SKSpriteNode? {
        
        return childNode(withName: "//homePokemon") as? SKSpriteNode
        
    }
    
    public final var guestPokemonSpriteNode: SKSpriteNode? {
        
        return childNode(withName: "//guestPokemon") as? SKSpriteNode
        
    }
    
    // MARK: Life Cycle
    
    public final override func didMove(to view: SKView) { }
    
    public final func updateData() {
        
        self.homePokemonSpriteNode?.removeFromParent()
        
        self.guestPokemonSpriteNode?.removeFromParent()
        
        guard
            let sceneDataProvider = sceneDataProvider
        else { return }
        
        let homePokemonType = type(of: sceneDataProvider.homePokemon)
        
        let homeSpriteNode = SKSpriteNode(
            texture: SKTexture(image: homePokemonType.image),
            size: CGSize(
                width: 100.0,
                height: 120.0
            )
        )
        
        homeSpriteNode.name = "//homePokemon"
        
        addChild(homeSpriteNode)
        
        setUpHomePokemonSpriteNode(homeSpriteNode)

        let guestPokemonType = type(of: sceneDataProvider.guestPokemon)
        
        let guestSpriteNode = SKSpriteNode(
            texture: SKTexture(image: guestPokemonType.image),
            size: CGSize(
                width: 100.0,
                height: 120.0
            )
        )
        
        guestSpriteNode.name = "//guestPokemon"
        
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
