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
    
//    private final let system = PokemonBattleSystem()
    
    private final var context = PokemonBattleContext(
        storage: [:]
    )
    
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
        
        let startScene = SKScene(fileNamed: "BattleStartScene")!
        
        startScene.scaleMode = .aspectFill
        
        gameView.presentScene(startScene)
        
        guard
            let currentTurn = server.record.turns.last
        else { fatalError() }
            
        let isFirstTurn = (server.record.turns.count == 1)
        
        if isFirstTurn {
            
            if !currentTurn.involveds.isEmpty {
                
                // Todo: restore context from involveds of last turn.
                print("Not implemented.")
            
            }
            else {
                
                server.record.readys.forEach { ready in
                    
                    let battlePokemons = ready.entities as! [BattlePokemon]
                    
                    self.context.storage[ready.player.id] = battlePokemons
                    
                }
                
            }
            
        }
        else {
            
            // Todo: restore context from the last turn.
            print("Not implemented.")
            
        }
        
        server.serverDelegate = self
        
    }
    
    public final override func viewDidAppear(_ animated: Bool) {
        
        if battleFieldScene?.view == nil {
            
            let battleFieldScene = BattleFieldScene(
                size: gameView.bounds.size
            )
            
            battleFieldScene.name = "battleScene"
            
            battleFieldScene.scaleMode = .aspectFill
            
            battleFieldScene.sceneDataProvider = self
            
            battleFieldScene.updateData()
            
            gameView.presentScene(battleFieldScene)
            
        }
        
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
    ) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) {
        
    }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool { return true }
    
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
        
        let homePlayerId = server.player.id
        
        return context.storage[homePlayerId]!.first!
        
    }
    
    public final var homeBattlePokemonImage: UIImage { return #imageLiteral(resourceName: "Pikachu") }
    
    public final var guestBattlePokemon: BattlePokemon {
        
        let guestPlayerId = server.player.id
        
        return context.storage[guestPlayerId]!.first!
        
    }
    
    public final var guestBattlePokemonImage: UIImage { return #imageLiteral(resourceName: "Charmander") }
    
}
