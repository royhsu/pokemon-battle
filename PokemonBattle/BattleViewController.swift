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
    
    // MARK: View Life Cycle
    
    public final override func loadView() { self.view = rootView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpRootView(rootView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: SKView) {
        
        view.ignoresSiblingOrder = true
        
        view.showsFPS = true
        
        view.showsNodeCount = true
        
        let scene = SKScene(fileNamed: "GameScene")!
        
        scene.scaleMode = .aspectFill
        
        view.presentScene(scene)
        
    }

    // MARK: Appearance

    public final override var prefersStatusBarHidden: Bool { return true }
    
}
