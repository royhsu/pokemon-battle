//
//  PokemonBattleServer.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleServerManagerDelegate

public protocol PokemonBattleServerManagerDelegate: class {
    
    func manager(
        _ manager: PokemonBattleServerManager,
        didJoin player: BattlePlayer
    )
    
    func manager(
        _ manager: PokemonBattleServerManager,
        didFailWith error: Error
    )
    
}

// MARK: - PokemonBattleServerManager

import TinyBattleKit

// Onwer only
public final class PokemonBattleServerManager: TurnBasedBattleServerDelegate {
    
    // MARK: Property
    
    public final let server: TurnBasedBattleServer
    
//    private final let system = PokemonBattleSystem()
    
    private final var context = PokemonBattleContext(storage: [:])
    
    public final weak var managerDelegate: PokemonBattleServerManagerDelegate?
    
    // MARK: Init
    
    public init(
        dataProvider: TurnBasedBattleServerDataProvider,
        record: TurnBasedBattleRecord
    ) {
        
        let server = TurnBasedBattleServer(
            dataProvider: dataProvider,
            player: record.owner,
            record: record
        )
        
        self.server = server
        
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
    
    public final func resume() {
        
        server.serverDelegate = self
        
        server.resume()
        
    }
    
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
            
            let player = server.serverDataProvider.fetchPlayer(id: request.playerId)!
            
            managerDelegate?.manager(
                self,
                didJoin: player
            )
            
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

