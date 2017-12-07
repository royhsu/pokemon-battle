//
//  PokemonBattlePlayer.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Player

import TinyBattleKit

public struct PokemonBattlePlayer: BattlePlayer {
    
    // MARK: Property
    
    public let id: String
    
    public let entities: [BattleEntity]
    
    // MARK: Init
    
    public init(
        id: String,
        entities: [BattleEntity]
    ) {
        
        self.id = id
        
        self.entities = entities
        
    }
    
}

// MARK: - Realm

public extension PokemonBattlePlayer {
    
    public init(_ player: BattlePlayerRealmObject) {
        
        self.init(
            id: player.id!,
            entities: player.entities.map(BattlePokemon.init)
        )
        
    }
    
}
