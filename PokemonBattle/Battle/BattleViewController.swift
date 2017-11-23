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
    
    public final let gameView = SKView()
    
    public final let battleFieldView = SKView()
    
    public final let battleMenuTableViewController = BattleMenuTableViewController(style: .plain)
    
    public final var battleMenuView: UIView {
        
        return battleMenuTableViewController.view!
        
    }
    
    internal final let stateMachine = BattleStateMachine(initialState: .start)
    
    internal final let battleDelegate: BattleDelegate
    
    public final var battleFieldScene: BattleFieldScene? {
        
        return battleFieldView.scene as? BattleFieldScene
        
    }
    
    // MARK: Init
    
    public init(battleDelegate: BattleDelegate) {
        
        self.battleDelegate = battleDelegate
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    deinit {
    
        NotificationCenter.default.removeObserver(
            self,
            name: .battlePokemonDataProviderDataDidChange,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: .allBattleAnimationsDidComplete,
            object: nil
        )
        
    }
    
    // MARK: View Life Cycle
    
    public final override func loadView() { self.view = gameView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChildViewController(battleMenuTableViewController)
        
        setUpGameView(
            gameView,
            battleFieldView: battleFieldView,
            battleMenuView: battleMenuView
        )
        
        battleMenuTableViewController.didMove(toParentViewController: self)
        
        setUpStateMachine(stateMachine)

        let startScene = SKScene(fileNamed: "BattleStartScene")!

        startScene.scaleMode = .aspectFill

        battleFieldView.presentScene(startScene)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(update),
            name: .battlePokemonDataProviderDataDidChange,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(allBattleAnimationsDidComplete),
            name: .allBattleAnimationsDidComplete,
            object: nil
        )
        
    }
    
    public final override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            self.stateMachine.state = .preparing

        }
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpGameView(
        _ gameView: SKView,
        battleFieldView: SKView,
        battleMenuView: UIView
    ) {
        
        gameView.ignoresSiblingOrder = true
        
        gameView.showsFPS = true
        
        gameView.showsNodeCount = true
        
        gameView.addSubview(battleFieldView)
        
        gameView.addSubview(battleMenuView)
        
        battleFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        battleMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        battleFieldView
            .leadingAnchor
            .constraint(equalTo: gameView.leadingAnchor)
            .isActive = true
        
        battleFieldView
            .topAnchor
            .constraint(equalTo: gameView.topAnchor)
            .isActive = true
        
        battleFieldView
            .bottomAnchor
            .constraint(equalTo: gameView.bottomAnchor)
            .isActive = true
        
        battleFieldView
            .trailingAnchor
            .constraint(equalTo: battleMenuView.leadingAnchor)
            .isActive = true
        
        battleFieldView
            .widthAnchor
            .constraint(
                equalTo: battleMenuView.widthAnchor,
                multiplier: 2.0
            )
            .isActive = true
        
        battleMenuView
            .topAnchor
            .constraint(equalTo: gameView.topAnchor)
            .isActive = true
        
        battleMenuView
            .trailingAnchor
            .constraint(equalTo: gameView.trailingAnchor)
            .isActive = true
        
        battleMenuView
            .bottomAnchor
            .constraint(equalTo: gameView.bottomAnchor)
            .isActive = true
        
    }
    
    fileprivate final func setUpStateMachine(_ stateMachine: BattleStateMachine) {
        
        stateMachine.stateMachineDelegate = self
        
    }

    // MARK: Appearance

    public final override var prefersStatusBarHidden: Bool { return true }
    
    // MARK: Action
    
    @objc public final func update(_ sender: Any) {
        
        battleFieldScene?.updateData()
        
        battleMenuTableViewController.tableView.reloadData()
        
    }
    
    @objc public final func allBattleAnimationsDidComplete(_ sender: Any) {
        
        stateMachine.state = .result
        
    }
    
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
                size: battleFieldView.bounds.size
            )
            
            battleFieldScene.name = "battleScene"
            
            battleFieldScene.sceneDataProvider = self
            
            battleFieldScene.scaleMode = .aspectFill
            
            battleFieldScene.updateData()
            
            battleFieldView.presentScene(battleFieldScene)
            
            battleMenuTableViewController.menuDataProvider = battleDelegate.battlePokemonDataProvider as? BattleMenuDataProvider
            battleMenuTableViewController.tableView.reloadData()
            
            battleMenuTableViewController.menuControllerDelegate = self
            
        case (.preparing, .fighting):
            
            battleMenuTableViewController.tableView.isUserInteractionEnabled = false
            
            battleMenuTableViewController.tableView.backgroundColor = .gray
            
        case (.fighting, .result):
            
            // Todo: determine whether the game is over.
            
            stateMachine.state = .preparing
            
        case (.result, .preparing):
            
            battleMenuTableViewController.tableView.isUserInteractionEnabled = true
            
            battleMenuTableViewController.tableView.backgroundColor = .white
            
        default: fatalError("Invalid state transition.")
            
        }
        
    }
    
    public func stateMachine(
        _ stateMachine: BattleStateMachine,
        didFailWith error: Error
    ) { print("\(error)") }
    
}

// MARK: - BattleFieldSceneDataProvider

extension BattleViewController: BattleFieldSceneDataProvider {
    
    public final var homeBattlePokemon: BattlePokemon? {
        
        return battleDelegate.battlePokemonDataProvider?.homeBattlePokemon
        
    }
    
    public final var guestBattlePokemon: BattlePokemon? {
        
        return battleDelegate.battlePokemonDataProvider?.guestBattlePokemon
        
    }
    
}

// MARK - BattleMenuTableViewControllerDelegate

extension  BattleViewController: BattleMenuTableViewControllerDelegate {
    
    public func tableViewController(
        _ tableViewController: BattleMenuTableViewController,
        didSelectSkillAt index: Int
    ) {
        
        guard
            let battleFieldScene = battleFieldScene,
            let battlePokemonDataProvider = battleDelegate.battlePokemonDataProvider,
            let homeBattlePokemon = battlePokemonDataProvider.homeBattlePokemon,
            let guestBattlePokemon = battlePokemonDataProvider.guestBattlePokemon
        else { return }
        
        stateMachine.state = .fighting
        
        let homePokemonFirstSkillType = homeBattlePokemon.pokemon.skillTypes[index]
        
        battleDelegate.addBattleAction(
            homePokemonFirstSkillType.battleActionType.init(
                pokemon: homeBattlePokemon.pokemon,
                battleFieldScene: battleFieldScene
            ),
            targetBattlePokemonId: guestBattlePokemon.id
        )
        
        let guestPokemonFirstSkillType = guestBattlePokemon.pokemon.skillTypes.first!
        
        battleDelegate.addBattleAction(
            guestPokemonFirstSkillType.battleActionType.init(
                pokemon: guestBattlePokemon.pokemon,
                battleFieldScene: battleFieldScene
            ),
            targetBattlePokemonId: homeBattlePokemon.id
        )
        
        battleDelegate.performAllBattleActions()
        
    }
    
}
