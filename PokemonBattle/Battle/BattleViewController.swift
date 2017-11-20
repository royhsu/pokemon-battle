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
    
    // MARK: View Life Cycle
    
    public final override func loadView() { self.view = rootView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpRootView(rootView)
        
        setUpStateMachine(stateMachine)
        
        let scence = makeScene(for: stateMachine.state)
        
        rootView.presentScene(scence)
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if stateMachine.state == .start { stateMachine.state = .preparing }
        
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
    
    fileprivate final func makeScene(for state: BattleState) -> SKScene {
        
        switch state {
        
        case .start:
            
            let startScene = SKScene(fileNamed: "BattleStartScene")!
            
            startScene.scaleMode = .aspectFill
            
            return startScene
            
        case .preparing, .fighting, .result, .end: fatalError("Scene not implemented.")
            
        }
        
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
        
    }
    
    public func stateMachine(
        _ stateMachine: BattleStateMachine,
        didFailWith error: Error
    ) {
        
        // Todo: error handling
        print("\(error)")
        
    }
    
}
