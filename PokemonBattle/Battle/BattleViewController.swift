//
//  BattleViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleViewControllerDelegate

public protocol BattleViewControllerDelegate: class {
    
    func battleViewController(
        _ battleViewController: BattleViewController,
        didEndWith result: BattleResult
    )
    
}

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
    
    public final weak var controllerDelegate: BattleViewControllerDelegate?
    
    // MARK: Init
    
    public init(battleDelegate: BattleDelegate) {
        
        self.battleDelegate = battleDelegate
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    // MARK: Deinit
    
    deinit {
    
        print("deinit")
        
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
        
        guard
            let battlePokemonDataProvider = battleDelegate.battlePokemonDataProvider,
            let homeBattlePokemon = battlePokemonDataProvider.homeBattlePokemon,
            let guestBattlePokemon = battlePokemonDataProvider.guestBattlePokemon
        else { fatalError() }
        
        if guestBattlePokemon.remainingHealthPoint <= 0.0 {
            
            stateMachine.state = .result(.win)
            
        }
        else if homeBattlePokemon.remainingHealthPoint <= 0.0 {
            
            stateMachine.state = .result(.lose)
            
        }
        
    }
    
    @objc public final func allBattleAnimationsDidComplete(_ sender: Any) {
        
        stateMachine.state = .result(.tbd)
        
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
            
            battleFieldScene.backgroundSound.run(
                .play()
            )
            
            battleMenuTableViewController.menuDataProvider = battleDelegate.battlePokemonDataProvider as? BattleMenuDataProvider
            
            battleMenuTableViewController.tableView.reloadData()
            
            battleMenuTableViewController.menuControllerDelegate = self
            
        case (.preparing, .fighting):
            
            battleMenuTableViewController.tableView.isUserInteractionEnabled = false
            
        case (.fighting, .result(let value) ):
            
            switch value {
                
            case .win:
                
                controllerDelegate?.battleViewController(
                    self,
                    didEndWith: .win
                )
                
            case .lose:
                
                controllerDelegate?.battleViewController(
                    self,
                    didEndWith: .lose
                )
                
            case .tbd: stateMachine.state = .preparing
                
            }
            
        case (.result, .preparing):
            
            battleMenuTableViewController.tableView.isUserInteractionEnabled = true
            
            battleMenuTableViewController.tableView.selectRow(
                at: nil,
                animated: true,
                scrollPosition: .none
            )
            
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
        
        let selectedHomePokemonSkillType = homeBattlePokemon.pokemon.skillTypes[index]
        
        battleDelegate.addBattleAction(
            selectedHomePokemonSkillType.battleActionType.init(
                pokemon: homeBattlePokemon.pokemon,
                battleFieldScene: battleFieldScene
            ),
            targetBattlePokemonId: guestBattlePokemon.id
        )
        
        let randomGuestPokemonFirstSkillTypes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: guestBattlePokemon.pokemon.skillTypes) as! [PokemonSkill.Type]
        
        let selectedGuestPokemonSkillType = randomGuestPokemonFirstSkillTypes.first!
        
        battleDelegate.addBattleAction(
            selectedGuestPokemonSkillType.battleActionType.init(
                pokemon: guestBattlePokemon.pokemon,
                battleFieldScene: battleFieldScene
            ),
            targetBattlePokemonId: homeBattlePokemon.id
        )
        
        battleDelegate.performAllBattleActions()
        
    }
    
}
