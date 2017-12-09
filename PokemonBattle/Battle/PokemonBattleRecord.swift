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
    
    public let state: TurnBasedBattleServerState
    
    public let createdAtDate: Date
    
    public let updatedAtDate: Date
    
    public let owner: BattlePlayer
    
    public let joineds: [BattleJoined]
    
    public let readys: [BattleReady]
    
    public let isLocked: Bool
    
    public let turns: [TurnBasedBattleTurn]
    
    // MARK: Init
    
    public init(
        id: String,
        state: TurnBasedBattleServerState,
        createdAtDate: Date,
        updatedAtDate: Date,
        owner: BattlePlayer,
        joineds: [BattleJoined],
        readys: [BattleReady],
        isLocked: Bool,
        turns: [TurnBasedBattleTurn]
    ) {
    
        self.id = id
        
        self.state = state
        
        self.createdAtDate = createdAtDate
        
        self.updatedAtDate = updatedAtDate
        
        self.owner = owner
        
        self.joineds = joineds
        
        self.readys = readys
        
        self.isLocked = isLocked
        
        self.turns = turns
        
    }
    
}

// MARK: - Realm

public extension PokemonBattleRecord {
    
    public init(_ record: BattleRecordRealmObject) {
    
        self.init(
            id: record.id!,
            state: TurnBasedBattleServerState(rawValue: record.state)!,
            createdAtDate: record.createdAtDate,
            updatedAtDate: record.updatedAtDate,
            owner: PokemonBattlePlayer(record.owner!),
            joineds: record.joineds.map(PokemonBattleJoined.init),
            readys: record.readys.map(PokemonBattleReady.init),
            isLocked: record.isLocked,
            turns: record.turns.map(PokemonBattleTurn.init)
        )
        
    }
    
}
