//
//  PokemonBattleServer.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleServerManager

import TinyBattleKit

public final class PokemonBattleServerManager: TurnBasedBattleServerDelegate {
    
    // MARK: Property
    
    private final let server: TurnBasedBattleServer
    
//    private final let system = PokemonBattleSystem()
    
    private final var context = PokemonBattleContext(storage: [:])
    
    public init(server: TurnBasedBattleServer) {
        
        self.server = server
        
        server.serverDelegate = self
        
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
    
    public final func open() { server.resume() }
    
    // MARK: TurnBasedBattleServerDelegate
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
        // waiting for clients
        
    }
    
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
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool {
    
        return true
        
    }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) {
        
        if let request = request as? PlayerJoinBattleRequest {
            
            // load guest pokemons from data provider into context.
            
        }
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) {
        
    }
    
}

//TurnBasedBattleServer(
//    dataProvider: realmServerDataProvider!,
//    player: PokemonBattlePlayer(player!),
//    record: record
//)

