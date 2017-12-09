//
//  PokemonInvolvedBattlePlayer.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 08/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonInvolvedBattlePlayer

import TinyBattleKit

public struct PokemonBattleInvolved: BattleInvolved {
    
    // MARK: Property
    
    public let id: String
    
    public let player: BattlePlayer
    
    public let entities: [BattleEntity]
    
    public let actions: [BattleAction]
    
    // MARK: Init
    
    public init(
        id: String,
        player: BattlePlayer,
        entities: [BattleEntity],
        actions: [BattleAction]
    ) {
        
        self.id = id
        
        self.player = player
        
        self.entities = entities
        
        self.actions = actions
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleInvolved {
    
    public init(_ involved: BattleInvolvedRealmObject) {
        
        // Todo: add actions
        
        self.init(
            id: involved.id!,
            player: PokemonBattlePlayer(involved.player!),
            entities: involved.entities.map(BattlePokemon.init),
            actions: involved.actions.map(PokemonBattleAction.init)
        )
        
    }
    
}
