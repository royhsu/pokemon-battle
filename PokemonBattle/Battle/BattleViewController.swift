//
//  BattleViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleViewController

import UIKit
import SpriteKit
import GameplayKit

public final class BattleViewController: UIViewController {

    // MARK: Property
    
    public final let rootView = SKView()
    
    internal final let stateMachine = BattleStateMachine(initialState: .start)
    
    public final let homePokemon: Pokemon = Pikachu()
    
    public final let guestPokemon: Pokemon = Charmander()
    
    // MARK: View Life Cycle
    
    public final override func loadView() { self.view = rootView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpRootView(rootView)
        
        setUpStateMachine(stateMachine)
        
        let startScene = SKScene(fileNamed: "BattleStartScene")!
        
        startScene.scaleMode = .aspectFill
        
        rootView.presentScene(startScene)
        
    }
    
    public final override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.stateMachine.state = .preparing
            
        }
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: SKView) {
        
        view.ignoresSiblingOrder = true
        
        view.showsFPS = true
        
        view.showsNodeCount = true
        
    }
    
    fileprivate final func setUpStateMachine(_ stateMachine: BattleStateMachine) {
        
        stateMachine.stateMachineDelegate = self
        
    }

    // MARK: Appearance

    public final override var prefersStatusBarHidden: Bool { return true }
    
}

// MARK: - BattleStateMachineDelegate

extension BattleViewController: BattleStateMachineDelegate {
    
    public func stateMachine(
        _ stateMachine: BattleStateMachine,
        didTranstionFrom from: BattleState,
        to: BattleState
    ) {
        
        switch (from, to) {
            
        case (.start, .preparing):
            
            let battleFieldScene = BattleFieldScene(
                size: view.bounds.size
            )
            
            battleFieldScene.sceneDataProvider = self
            
            battleFieldScene.scaleMode = .aspectFill
            
            battleFieldScene.updateData()
            
            rootView.presentScene(battleFieldScene)
            
        default: break
            
        }
        
    }
    
    public func stateMachine(
        _ stateMachine: BattleStateMachine,
        didFailWith error: Error
    ) {
        
        // Todo: error handling
        
        print("\(error)")
        
    }
    
}

extension BattleViewController: BattleFieldSceneDataProvider {
    
    public var homePokemonSpriteNode: SKSpriteNode {
        
        let homePokemonType = type(of: homePokemon)
        
        let spriteNode = SKSpriteNode(
            texture: SKTexture(image: homePokemonType.image),
            size: CGSize(
                width: 100.0,
                height: 120.0
            )
        )
        
        spriteNode.name = "homePokemon"
        
        return spriteNode
        
    }
    
    public var guestPokemonSpriteNode: SKSpriteNode {
        
        let guestPokemonType = type(of: guestPokemon)
        
        let spriteNode = SKSpriteNode(
            texture: SKTexture(image: guestPokemonType.image),
            size: CGSize(
                width: 100.0,
                height: 120.0
            )
        )
        
        spriteNode.name = "guestPokemon"
        
        return spriteNode
        
    }
    
}
