//
//  BattleFieldScene.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleFieldSceneDataProvider

public protocol BattleFieldSceneDataProvider: class {
    
    var homeBattlePokemon: BattlePokemon? { get }
    
    var guestBattlePokemon: BattlePokemon? { get }
    
}

// MARK: - BattleFieldScene

import SpriteKit

public final class BattleFieldScene: SKScene {
    
    // MARK: Property
    
    public final weak var sceneDataProvider: BattleFieldSceneDataProvider?
    
    public final let homePokemonSpriteNode = SKSpriteNode()
    
    public final let guestPokemonSpriteNode = SKSpriteNode()
    
    public final let homeHpLabelNode = SKLabelNode(text: nil)
    
    public final let guestHpLabelNode = SKLabelNode(text: nil)
    
    // MARK: Life Cycle
    
    public final override func didMove(to view: SKView) {
        
        addChild(homeHpLabelNode)
        
        addChild(homePokemonSpriteNode)
        
        addChild(guestHpLabelNode)
        
        addChild(guestPokemonSpriteNode)
        
        updateData()
        
    }
    
    // MARK: Update
    
    public final func updateData() {
    
        setUpHomeHpLabelNode(
            homeHpLabelNode,
            battlePokemon: sceneDataProvider?.homeBattlePokemon
        )
        
        setUpHomePokemonSpriteNode(
            homePokemonSpriteNode,
            battlePokemon: sceneDataProvider?.homeBattlePokemon
        )
        
        setUpGuestHpLabelNode(
            guestHpLabelNode,
            battlePokemon: sceneDataProvider?.guestBattlePokemon
        )
        
        setUpGuestPokemonSpriteNode(
            guestPokemonSpriteNode,
            battlePokemon: sceneDataProvider?.guestBattlePokemon
        )
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpHomePokemonSpriteNode(
        _ spriteNode: SKSpriteNode,
        battlePokemon: BattlePokemon?
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
        
        guard
            let pokemon = battlePokemon?.pokemon
        else { return }
            
        let pokemonType = type(of: pokemon)
        
        spriteNode.texture = SKTexture(image: pokemonType.image)
        
    }
    
    fileprivate final func setUpGuestPokemonSpriteNode(
        _ spriteNode: SKSpriteNode,
        battlePokemon: BattlePokemon?
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
        
        guard
            let pokemon = battlePokemon?.pokemon
        else { return }
        
        let pokemonType = type(of: pokemon)
        
        spriteNode.texture = SKTexture(image: pokemonType.image)
        
    }
    
    fileprivate final func setUpHomeHpLabelNode(
        _ labelNode: SKLabelNode,
        battlePokemon: BattlePokemon?
    ) {
        
        labelNode.position = CGPoint(
            x: frame.maxX - 100.0,
            y: 100.0 + frame.minY
        )
        
        guard
            let battlePokemon = battlePokemon
        else {
            
            labelNode.text = "HP: 0"
            
            return
            
        }
        
        let healthPoint = battlePokemon.remainingHealthPoint
        
        labelNode.text = "HP: \(healthPoint)"
        
    }
    
    fileprivate final func setUpGuestHpLabelNode(
        _ labelNode: SKLabelNode,
        battlePokemon: BattlePokemon?
    ) {
        
        labelNode.position = CGPoint(
            x: 100.0 + frame.minX,
            y: frame.maxY - 100.0
        )
        
        guard
            let battlePokemon = battlePokemon
        else {
            
            labelNode.text = "HP: 0"
            
            return
                
        }
        
        let healthPoint = battlePokemon.remainingHealthPoint
        
        labelNode.text = "HP: \(healthPoint)"
        
    }
 
}
