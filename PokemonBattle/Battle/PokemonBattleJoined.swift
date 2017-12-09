//
//  PokemonBattleJoined.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 08/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleJoined

import TinyBattleKit

public struct PokemonBattleJoined: BattleJoined {
    
    // MARK: Property
    
    public let id: String
    
    public let player: BattlePlayer
    
    // MARK: Init
    
    public init(
        id: String,
        player: BattlePlayer
    ) {
        
        self.id = id
        
        self.player = player
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleJoined {
    
    public init(_ joined: BattleJoinedRealmObject) {
        
        // Todo: add actions
        
        self.init(
            id: joined.id!,
            player: PokemonBattlePlayer(joined.player!)
        )
        
    }
    
}
