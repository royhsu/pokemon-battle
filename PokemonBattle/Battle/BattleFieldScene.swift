//
//  BattleFieldScene.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleFieldSceneDataProvider

public protocol BattleFieldSceneDataProvider: class {
    
    var homeBattlePokemon: BattlePokemon { get }
    
    var guestBattlePokemon: BattlePokemon { get }
    
}

// MARK: - BattleFieldScene

import SpriteKit

public final class BattleFieldScene: SKScene {
    
    // MARK: BattleField
    
    public struct BattleField {
        
        public static let homeName = "//homePokemon"
        
        public static let guestName = "//guestPokemon"
        
    }
    
    // MARK: Property
    
    public final weak var sceneDataProvider: BattleFieldSceneDataProvider?
    
    public final var homePokemonSpriteNode: SKSpriteNode? {
        
        return childNode(withName: BattleField.homeName) as? SKSpriteNode
        
    }
    
    public final var guestPokemonSpriteNode: SKSpriteNode? {
        
        return childNode(withName: BattleField.guestName) as? SKSpriteNode
        
    }
    
    public final let homeHpLabelNode = SKLabelNode(text: nil)
    
    public final let guestHpLabelNode = SKLabelNode(text: nil)
    
    // MARK: Life Cycle
    
    public final override func didMove(to view: SKView) {
        
        setUpHomeHpLabelNode(homeHpLabelNode)
        
        setUpGuestHpLabelNode(guestHpLabelNode)
        
    }
    
    // MARK: Update
    
    public final func updateData() {
        
        self.homePokemonSpriteNode?.removeFromParent()
        
        self.homeHpLabelNode.removeFromParent()
        
        self.guestPokemonSpriteNode?.removeFromParent()
        
        self.guestHpLabelNode.removeFromParent()
        
        guard
            let sceneDataProvider = sceneDataProvider
        else { return }
        
        let homePokemonType = type(of: sceneDataProvider.homeBattlePokemon.pokemon)
        
        let homeSpriteNode = SKSpriteNode(
            texture: SKTexture(image: homePokemonType.image),
            size: CGSize(
                width: 100.0,
                height: 120.0
            )
        )
        
        homeSpriteNode.name = BattleField.homeName
        
        addChild(homeSpriteNode)
        
        setUpHomePokemonSpriteNode(homeSpriteNode)
        
        addChild(homeHpLabelNode)
        
        setUpHomeHpLabelNode(homeHpLabelNode)

        let guestPokemonType = type(of: sceneDataProvider.guestBattlePokemon.pokemon)
        
        let guestSpriteNode = SKSpriteNode(
            texture: SKTexture(image: guestPokemonType.image),
            size: CGSize(
                width: 100.0,
                height: 120.0
            )
        )
        
        guestSpriteNode.name = BattleField.guestName
        
        addChild(guestSpriteNode)
        
        setUpGuestPokemonSpriteNode(guestSpriteNode)
        
        addChild(guestHpLabelNode)
        
        setUpGuestHpLabelNode(guestHpLabelNode)
        
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
    
    fileprivate final func setUpHomeHpLabelNode(_ labelNode: SKLabelNode) {
        
        labelNode.position = CGPoint(
            x: frame.maxX - 100.0,
            y: 100.0 + frame.minY
        )
        
        guard
            let sceneDataProvider = sceneDataProvider
        else {
            
            labelNode.text = "HP: 0"
            
            return
            
        }
        
        let healthPoint = sceneDataProvider.homeBattlePokemon.healthPoint
        
        labelNode.text = "HP: \(healthPoint)"
        
    }
    
    fileprivate final func setUpGuestHpLabelNode(_ labelNode: SKLabelNode) {
        
        labelNode.position = CGPoint(
            x: 100.0 + frame.minX,
            y: frame.maxY - 100.0
        )
        
        guard
            let sceneDataProvider = sceneDataProvider
        else {
            
            labelNode.text = "HP: 0"
            
            return
                
        }
        
        let healthPoint = sceneDataProvider.guestBattlePokemon.healthPoint
        
        labelNode.text = "HP: \(healthPoint)"
        
    }
 
}
