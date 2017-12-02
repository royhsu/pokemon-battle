//
//  Player.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Player

import TinyBattleKit

public struct Player: BattlePlayer {
    
    // MARK: Property
    
    public let id: String
    
    // MARK: Init
    
    public init(id: String) { self.id = id }
    
}

// MARK: Realm

public extension Player {
    
    public init(_ player: BattlePlayerRealmObject) {
        
        self.init(
            id: player.id!
        )
        
    }
    
}
