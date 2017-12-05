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
    
    public let createdAtDate: Date
    
    public let updatedAtDate: Date
    
    public let owner: BattlePlayer
    
    public let isLocked: Bool
    
    public var turns: [TurnBasedBattleTurn]
    
    // MARK: Init
    
    public init(
        id: String,
        createdAtDate: Date,
        updatedAtDate: Date,
        owner: BattlePlayer,
        isLocked: Bool,
        turns: [TurnBasedBattleTurn]
    ) {
    
        self.id = id
        
        self.createdAtDate = createdAtDate
        
        self.updatedAtDate = updatedAtDate
        
        self.owner = owner
        
        self.isLocked = isLocked
        
        self.turns = turns
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleRecord {
    
    public init(_ record: BattleRecordRealmObject) {
        
        self.init(
            id: record.id!,
            createdAtDate: record.createdAtDate,
            updatedAtDate: record.updatedAtDate,
            owner: PokemonBattlePlayer(record.owner!),
            isLocked: record.isLocked,
            turns: record.turns.map(PokemonBattleTurn.init)
        )
        
    }
    
}
