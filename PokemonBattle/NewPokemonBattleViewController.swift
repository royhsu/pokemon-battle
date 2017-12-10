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
    
    public final var battleFieldScene: BattleFieldScene? {
        
        return gameView.scene as? BattleFieldScene
        
    }
    
    // MARK: Init
    
    public init(server: TurnBasedBattleServer) {
        
        self.server = server
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    // MARK: - View Life Cycle
    
    public final override func loadView() { self.view = gameView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpNavigationItem(navigationItem)
        
        let startScene = SKScene(fileNamed: "BattleStartScene")!
        
        startScene.scaleMode = .aspectFill
        
        gameView.presentScene(startScene)
        
        guard
            let currentTurn = server.record.turns.last
        else { fatalError() }
            
        let isFirstTurn = (server.record.turns.count == 1)
        
        if isFirstTurn {
            
//            if !currentTurn.involveds.isEmpty {
//
//                // Todo: restore context from involveds of last turn.
//                print("Not implemented.")
//
//            }
//            else {
            
                server.record.readys.forEach { ready in
                    
                    let battlePokemons = ready.entities as! [BattlePokemon]
                    
                    self.context.storage[ready.player.id] = battlePokemons
                    
                }
                
//            }
            
        }
        else {
            
            // Todo: restore context from the last turn.
            print("Not implemented.")
            
        }
        
        server.serverDelegate = self
        
    }
    
    public final override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
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
    
    fileprivate final func setUpNavigationItem(_ navigationItem: UINavigationItem) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString(
                "Skill",
                comment: ""
            ),
            style: .plain,
            target: self,
            action: #selector(performSkill)
        )
        
    }
    
    // MARK: Action
    
    @objc public final func performSkill(_ sender: Any) {
        
        // Todo: replace with selected skills by battle entity
        
        let battleAction = PokemonBattleAction(
            id: UUID().uuidString,
            priority: 100.0 + homeBattlePokemon.speed,
            source: homeBattlePokemon,
            destinations: [ guestBattlePokemon ]
        )
        
        server.respond(
            to: InvolvedBattleRequest(
                involved: PokemonBattleInvolved(
                    id: UUID().uuidString,
                    player: server.player,
                    entities: context.storage[server.player.id]!,
                    actions: [ battleAction ]
                )
            )
        )
        
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

extension NewPokemonBattleViewController: TurnBasedBattleServerDelegate {
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didUpdate record: TurnBasedBattleRecord
    ) {
        
        
    }
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didStartTurn turn: TurnBasedBattleTurn
    ) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) {
        
        print(
            #function,
            server.player.id
        )
        
        let actions = turn.involveds.flatMap { $0.actions as! [PokemonBattleAction] }
        
        actions.forEach { action in
            
            // Todo: source id is player id
            let sourceId = action.source.id
            
            // Todo: destination id is player id
            let destinationIds = action.destinations.map { $0.id }
            
            let lightningSkill = LightningPokemonSkill()
            
            let lightningSkillProvider = lightningSkill.makeProvider(
                id: action.id,
                priority: action.priority,
                sourceId: sourceId,
                destinationIds: destinationIds,
                context: PokemonSkillAnimatorContext(
                    sourceId: sourceId,
                    sourceSprite: battleFieldScene!.homePokemonSpriteNode,
                    sourceHPLabel: battleFieldScene!.homeHpLabelNode,
                    destinationId: destinationIds.first!,
                    destinationSprite: battleFieldScene!.guestPokemonSpriteNode,
                    destinationHPLabel: battleFieldScene!.guestHpLabelNode
                )
            )
            
            _ = system.respond(to: lightningSkillProvider)
            
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
    
    public final var homeBattlePokemonImage: UIImage { return #imageLiteral(resourceName: "Pikachu") }
    
    public final var guestBattlePokemon: BattlePokemon {
        
        // Todo: better handling
        let guestPlayer = server
            .record
            .readys
            .filter { $0.player.id != server.player.id }
            .first!
        
        return context.storage[guestPlayer.player.id]!.first!
        
    }
    
    public final var guestBattlePokemonImage: UIImage { return #imageLiteral(resourceName: "Charmander") }
    
}
