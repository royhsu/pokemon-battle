//
//  PokemonBattleServer.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleViewController

import UIKit
import SpriteKit
import TinyBattleKit

public final class NewPokemonBattleViewController: UIViewController {
    
    // MARK: Property
    
    public final let server: TurnBasedBattleServer
    
    private final var context = PokemonBattleContext(
        storage: [:]
    ) {
        
        didSet {
            
            // Todo: bad workaround
            if context.storage.count > 1 {
            
                battleFieldScene?.updateData()
                
            }
            
            
        }
        
    }
    
    private final let system = PokemonBattleSystem()
    
    private final let gameView = SKView()
    
    private final var menuView: UIView { return menuViewController.view! }
    
    private final let menuViewController = BattleMenuTableViewController()
    
    private final var battleFieldScene: BattleFieldScene? {
        
        return gameView.scene as? BattleFieldScene
        
    }
    
    private final let pokedex: Pokedex
    
    // MARK: Init
    
    public init(
        server: TurnBasedBattleServer,
        pokedex: Pokedex
    ) {
        
        self.server = server
        
        self.pokedex = pokedex
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    // MARK: - View Life Cycle
    
//    public override func loadView() {
//        view = gameView
//    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(
            true,
            animated: false
        )
        
        setUpRootView(
            view,
            gameView: gameView,
            menuView: menuView
        )
        
        menuViewController.controllerDataSource = self
        
        menuViewController.controllerDelegate = self
            
        let isFirstTurn = (server.record.turns.count == 1)
        
        if isFirstTurn {
            
            server.record.readys.forEach { ready in
                
                let battlePokemons = ready.entities as! [BattlePokemon]
                
                self.context.storage[ready.player.id] = battlePokemons
                
            }
            
        }
        else {
            
            // Todo: restore context from the last turn.
            print("Not implemented.")
            
        }
        
        server.serverDelegate = self
        
    }
    
    public final override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if battleFieldScene?.view == nil {
            
            let battleFieldScene = BattleFieldScene(
                size: gameView.bounds.size
            )
            
            battleFieldScene.name = "battleScene"
            
            battleFieldScene.scaleMode = .aspectFill
            
            battleFieldScene.sceneDataProvider = self
            
            // Todo: bad workaround
            if context.storage.count > 1 {
                
                battleFieldScene.updateData()
                
            }
            
            gameView.presentScene(battleFieldScene)
            
        }
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(
        _ rootView: UIView,
        gameView: SKView,
        menuView: UIView
    ) {
        
        addChildViewController(menuViewController)
        
        gameView.translatesAutoresizingMaskIntoConstraints = false
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        rootView.addSubview(gameView)
        
        rootView.addSubview(menuView)
        
        gameView
            .leadingAnchor
            .constraint(equalTo: rootView.leadingAnchor)
            .isActive = true
        
        gameView
            .topAnchor
            .constraint(equalTo: rootView.topAnchor)
            .isActive = true
        
        gameView
            .bottomAnchor
            .constraint(equalTo: rootView.bottomAnchor)
            .isActive = true
        
        menuView
            .trailingAnchor
            .constraint(equalTo: rootView.trailingAnchor)
            .isActive = true
        
        menuView
            .topAnchor
            .constraint(equalTo: rootView.topAnchor)
            .isActive = true
        
        menuView
            .bottomAnchor
            .constraint(equalTo: rootView.bottomAnchor)
            .isActive = true
        
        gameView
            .trailingAnchor
            .constraint(equalTo: menuView.leadingAnchor)
            .isActive = true
        
        gameView
            .widthAnchor
            .constraint(
                equalTo: menuView.widthAnchor,
                multiplier: 3.0 / 1.0
            )
            .isActive = true
        
        let startScene = SKScene(fileNamed: "BattleStartScene")!

        startScene.scaleMode = .aspectFill

        gameView.presentScene(startScene)
        
        menuViewController.didMove(toParentViewController: self)
        
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

extension NewPokemonBattleViewController: TurnBasedBattleServerDelegate {
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didUpdate record: TurnBasedBattleRecord
    ) { }
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didStartTurn turn: TurnBasedBattleTurn
    ) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) {
        
        let actions = turn.involveds.flatMap { $0.actions as! [PokemonBattleAction] }
        
        actions.forEach { action in
            
            let sourceId = action.source.id
            
            let destinationIds = action.destinations.map { $0.id }
            
            let sourceSprite =
                (sourceId == homeBattlePokemon.id)
                ? battleFieldScene!.homePokemonSpriteNode
                : battleFieldScene!.guestPokemonSpriteNode
            
            let sourceHpLabel =
                (sourceId == homeBattlePokemon.id)
                ? battleFieldScene!.homeHpLabelNode
                : battleFieldScene!.guestHpLabelNode
            
            let guestSprite =
                (sourceId == guestBattlePokemon.id)
                ? battleFieldScene!.homePokemonSpriteNode
                : battleFieldScene!.guestPokemonSpriteNode
            
            let guestHpLabel =
                (sourceId == guestBattlePokemon.id)
                ? battleFieldScene!.homeHpLabelNode
                : battleFieldScene!.guestHpLabelNode
            
            let context = PokemonSkillAnimatorContext(
                sourceId: sourceId,
                sourceSprite: sourceSprite,
                sourceHPLabel: sourceHpLabel,
                destinationId: destinationIds.first!,
                destinationSprite: guestSprite,
                destinationHPLabel: guestHpLabel
            )
            
            var pokemonSkillProvider: AnyBattleActionProvider<PokemonSkillAnimator>?
            
            switch action.skill.name {
                
            case "LIGHTNING":
                
                let provider = LightningPokemonSkillProvider(
                    id: action.id,
                    priority: action.priority,
                    sourceId: sourceId,
                    destinationIds: destinationIds,
                    context: context
                )
                
                pokemonSkillProvider = AnyBattleActionProvider(provider)
                
            case "FIRE":
                
                let provider = FirePokemonSkillProvider(
                    id: action.id,
                    priority: action.priority,
                    sourceId: sourceId,
                    destinationIds: destinationIds,
                    context: context
                )
                
                pokemonSkillProvider = AnyBattleActionProvider(provider)
                
            default: print("Undefined skill: \(action.skill.name).")
                
            }
    
            guard
                let skillProvider = pokemonSkillProvider
            else { return }

            system.respond(to: skillProvider)
            
        }
        
        system
            .run(with: context)
            .then { updatedContext in
                
                self.context = updatedContext
                
            }
            .catch { error in
                
                // Todo: error handling
                
                print(
                    #function,
                    "\(error)"
                )
                
            }
        
    }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool { return false }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) {
       
        print(
            #function,
            "\(error)"
        )
        
    }
    
}

// MARK: - BattleFieldSceneDataProvider

extension NewPokemonBattleViewController: BattleFieldSceneDataProvider {
    
    public final var homeBattlePokemon: BattlePokemon {
        
        // Todo: better handling
        let homePlayerId = server.player.id
        
        // Todo: client may access context too early that server doesn't set it up.
        return context.storage[homePlayerId]!.first!
        
    }
    
    public final var homeBattlePokemonImage: UIImage {
        
        let isPikachu = homeBattlePokemon.skills.contains { $0.name == "LIGHTNING" }
        
        return isPikachu ? #imageLiteral(resourceName: "Pikachu") : #imageLiteral(resourceName: "Charmander")
        
    }
    
    public final var guestBattlePokemon: BattlePokemon {
        
        // Todo: better handling
        let guestPlayer = server
            .record
            .readys
            .filter { $0.player.id != server.player.id }
            .first!
        
        return context.storage[guestPlayer.player.id]!.first!
        
    }
    
    public final var guestBattlePokemonImage: UIImage {
        
        let isChamander = guestBattlePokemon.skills.contains { $0.name == "FIRE" }
        
        return isChamander ? #imageLiteral(resourceName: "Charmander") : #imageLiteral(resourceName: "Pikachu")
        
    }
    
}

// MARK: - BattleMenuTableViewControllerDataSource

extension NewPokemonBattleViewController: BattleMenuTableViewControllerDataSource {
    
    public final func numberOfPokemonSkills() -> Int {
        
        return homeBattlePokemon.skills.count
        
    }
    
    public final func titleForPokemonSkill(at index: Int) -> String? {
        
        return homeBattlePokemon.skills[index].name
        
    }
    
}

// MARK: - BattleMenuTableViewControllerDelegate

extension NewPokemonBattleViewController: BattleMenuTableViewControllerDelegate {
    
    public final func controller(
        _ controller: BattleMenuTableViewController,
        didSelectSkillAt index: Int
    ) {
    
        let selectedSkill = homeBattlePokemon.skills[index]
        
        let involved = PokemonBattleInvolved(
            id: UUID().uuidString,
            player: server.player,
            entities: [ homeBattlePokemon ],
            actions: [
                PokemonBattleAction(
                    id: UUID().uuidString,
                    skill: selectedSkill,
                    priority: 100.0 + homeBattlePokemon.speed,
                    source: homeBattlePokemon,
                    destinations: [ guestBattlePokemon ]
                )
            ]
        )
        
        server.respond(
            to: InvolvedBattleRequest(involved: involved)
        )
        
    }
    
}
