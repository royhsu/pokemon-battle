//
//  BattleTurn.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleTurn

import TinyBattleKit

public struct BattleTurn: TurnBasedBattleTurn {
    
    // MARK: Property
    
    public let id: String
    
    public var involvedPlayers: [BattlePlayer]
    
    // MARK: Init
    
    public init(
        id: String,
        involvedPlayers: [BattlePlayer]
    ) {
    
        self.id = id
        
        self.involvedPlayers = involvedPlayers
        
    }
    
}

// MARK: Realm

public extension BattleTurn {
    
    public init(_ turn: BattleTurnRealmObject) {
        
        self.init(
            id: turn.id!,
            involvedPlayers: turn.invovledPlayers.map(Player.init)
        )
        
    }
    
}



