//
//  BattleFieldScene.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleFieldScene

import SpriteKit

public final class BattleFieldScene: SKScene {
    
    // MARK: Property
    
    public final weak var sceneDataProvider: BattleFieldSceneDataProvider?
    
    public final let homePokemonSpriteNode = SKSpriteNode()
    
    public final let guestPokemonSpriteNode = SKSpriteNode()
    
    public final let homeHpLabelNode = SKLabelNode(text: nil)
    
    public final let guestHpLabelNode = SKLabelNode(text: nil)
    
    public final let backgroundSound = SKAudioNode(fileNamed: "Battle.mp3")
    
    // MARK: Life Cycle
    
    public final override func didMove(to view: SKView) {
        
        addChild(homeHpLabelNode)
        
        addChild(homePokemonSpriteNode)
        
        addChild(guestHpLabelNode)
        
        addChild(guestPokemonSpriteNode)
        
        addChild(backgroundSound)
        
    }
    
    // MARK: Update
    
    public final func updateData() {
        
        guard
            let sceneDataProvider = sceneDataProvider
        else { return }
    
        setUpHomeHpLabelNode(
            homeHpLabelNode,
            battlePokemon: sceneDataProvider.homeBattlePokemon
        )
        
        setUpHomePokemonSpriteNode(
            homePokemonSpriteNode,
            image: sceneDataProvider.homeBattlePokemonImage
        )
        
        setUpGuestHpLabelNode(
            guestHpLabelNode,
            battlePokemon: sceneDataProvider.guestBattlePokemon
        )
        
        setUpGuestPokemonSpriteNode(
            guestPokemonSpriteNode,
            image: sceneDataProvider.guestBattlePokemonImage
        )
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpHomePokemonSpriteNode(
        _ spriteNode: SKSpriteNode,
        image: UIImage
    ) {
        
        spriteNode.size = CGSize(
            width: 100.0,
            height: 120.0
        )
        
        spriteNode.position = CGPoint(
            x: 100.0 + frame.minX,
            y: 100.0 + frame.minY
        )
        
        spriteNode.texture = nil
        
        spriteNode.texture = SKTexture(image: image)
        
    }
    
    fileprivate final func setUpGuestPokemonSpriteNode(
        _ spriteNode: SKSpriteNode,
        image: UIImage
    ) {
        
        spriteNode.size = CGSize(
            width: 100.0,
            height: 120.0
        )
        
        spriteNode.position = CGPoint(
            x: frame.maxX - 100.0,
            y: frame.maxY - 100.0
        )
        
        spriteNode.texture = nil
        
        spriteNode.texture = SKTexture(image: image)
        
    }
    
    fileprivate final func setUpHomeHpLabelNode(
        _ labelNode: SKLabelNode,
        battlePokemon: BattlePokemon
    ) {
        
        labelNode.position = CGPoint(
            x: frame.maxX - 100.0,
            y: 100.0 + frame.minY
        )
        
        let remainingHealth = Int(battlePokemon.remainingHealth)
        
        labelNode.text = "HP: \(remainingHealth)"
        
    }
    
    fileprivate final func setUpGuestHpLabelNode(
        _ labelNode: SKLabelNode,
        battlePokemon: BattlePokemon
    ) {
        
        labelNode.position = CGPoint(
            x: 100.0 + frame.minX,
            y: frame.maxY - 100.0
        )
        
        let remainingHealth = Int(battlePokemon.remainingHealth)
        
        labelNode.text = "HP: \(remainingHealth)"
        
    }
 
}
