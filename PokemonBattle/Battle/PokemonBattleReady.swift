//
//  PokemonBattleReady.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 08/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleReady

import TinyBattleKit

public struct PokemonBattleReady: BattleReady {
    
    // MARK: Property
    
    public let id: String
    
    public let player: BattlePlayer
    
    public let entities: [BattleEntity]
    
    // MARK: Init
    
    public init(
        id: String,
        player: BattlePlayer,
        entities: [BattleEntity]
    ) {
        
        self.id = id
        
        self.player = player
        
        self.entities = entities
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleReady {
    
    public init(_ ready: BattleReadyRealmObject) {
        
        // Todo: add actions
        
        self.init(
            id: ready.id!,
            player: PokemonBattlePlayer(ready.player!),
            entities: ready.entities.map(BattlePokemon.init)
        )
        
    }
    
}
