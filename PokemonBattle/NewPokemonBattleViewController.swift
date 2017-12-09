//
//  PokemonBattleServer.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleViewController

import UIKit
import TinyBattleKit

public final class NewPokemonBattleViewController: UIViewController {
    
    // MARK: Property
    
    public final let server: TurnBasedBattleServer
    
//    private final let system = PokemonBattleSystem()
    
//    private final var context = PokemonBattleContext(storage: [:])
    
    // MARK: Init
    
    public init(server: TurnBasedBattleServer) {
        
        self.server = server
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        // load pokemons for home into context.
        
//        if context.storage.isEmpty {
//
//            print("No battle pokemons.")
//
//            return
//
//        }
        
        // save battle pokemons for context into database.
        
        // load context.
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }
    
    // MARK: - View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        server.serverDelegate = self
        
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
