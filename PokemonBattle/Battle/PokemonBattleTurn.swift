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
    
    public let involveds: [BattleInvolved]
    
    // MARK: Init
    
    public init(
        id: String,
        involveds: [BattleInvolved]
    ) {
    
        self.id = id
        
        self.involveds = involveds
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleTurn {
    
    public init(_ turn: BattleTurnRealmObject) {
        
        self.init(
            id: turn.id!,
            involveds: turn.involveds.map(PokemonBattleInvolved.init)
        )
        
    }
    
}
