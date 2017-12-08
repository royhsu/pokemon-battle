//
//  PokemonInvolvedBattlePlayer.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 08/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonInvolvedBattlePlayer

import TinyBattleKit

public struct PokemonInvolvedBattlePlayer: InvolvedBattlePlayer {
    
    // MARK: Property
    
    public let id: String
    
    public let entities: [BattleEntity]
    
    public let actions: [BattleAction]
    
    // MARK: Init
    
    public init(
        id: String,
        entities: [BattleEntity],
        actions: [BattleAction]
    ) {
        
        self.id = id
        
        self.entities = entities
        
        self.actions = actions
        
    }
    
}

// MARK: - Realm

public extension PokemonInvolvedBattlePlayer {
    
    public init(_ player: BattlePlayerRealmObject) {
        
        // Todo: add actions
        
        self.init(
            id: player.id!,
            entities: player.entities.map(BattlePokemon.init),
            actions: []
        )
        
    }
    
}