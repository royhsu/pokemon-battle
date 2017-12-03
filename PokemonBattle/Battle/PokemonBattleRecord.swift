//
//  PokemonBattleRecord.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleRecord

import TinyBattleKit

public struct PokemonBattleRecord: TurnBasedBattleRecord {
    
    // MARK: Property
    
    public let id: String
    
    public var turns: [TurnBasedBattleTurn]
    
    public let createdAtDate: Date
    
    public let updatedAtDate: Date
    
    // MARK: Init
    
    public init(
        id: String,
        turns: [TurnBasedBattleTurn],
        createdAtDate: Date,
        updatedAtDate: Date
    ) {
    
        self.id = id
        
        self.turns = turns
        
        self.createdAtDate = createdAtDate
        
        self.updatedAtDate = updatedAtDate
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleRecord {
    
    public init(_ record: BattleRecordRealmObject) {
        
        self.init(
            id: record.id!,
            turns: record.turns.map(PokemonBattleTurn.init),
            createdAtDate: record.createdAtDate,
            updatedAtDate: record.updatedAtDate
        )
        
    }
    
}
