//
//  PokemonBattleTurn.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleTurn

import TinyBattleKit

public struct PokemonBattleTurn: TurnBasedBattleTurn {
    
    // MARK: Property
    
    public let id: String
    
    public var involvedPlayers: [InvolvedBattlePlayer]
    
    // MARK: Init
    
    public init(
        id: String,
        involvedPlayers: [InvolvedBattlePlayer]
    ) {
    
        self.id = id
        
        self.involvedPlayers = involvedPlayers
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleTurn {
    
    public init(_ turn: BattleTurnRealmObject) {
        
        self.init(
            id: turn.id!,
            involvedPlayers: turn.invovledPlayers.map(PokemonInvolvedBattlePlayer.init)
        )
        
    }
    
}
