//
//  BattleSystem.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleSystem

import TinyBattleKit

public final class BattleSystem: TurnBasedBattle {
    
    public typealias Provider = AnyBattleActionProvider<BattleContext>
    
    // MARK: Property
    
    public final var actionProviders: [Provider] = []
    
    // Todo: remove unused state machine
    public final var stateMachine = BattleSystemStateMachine(state: .end)
    
    public final let server: TurnBasedBattleServer
    
    public init(
        ownerId: String,
        recordId: String
    ) {
        
        let server = TurnBasedBattleServer(
            ownerId: ownerId,
            recordId: recordId
        )
        
        self.server = server
        
        server.serverDelegate = self
        
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

extension BattleSystem: TurnBasedBattleServerDelegate {
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
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
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool { return false }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) {
        
    }
    
    public final func server(_ server: TurnBasedBattleServer, didFailWith error: Error) {
        
    }
    
}
