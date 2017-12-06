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
    
    public let joinedPlayers: [BattlePlayer]
    
    public let readyPlayers: [BattlePlayer]
    
    public let isLocked: Bool
    
    public let turns: [TurnBasedBattleTurn]
    
    // MARK: Init
    
    public init(
        id: String,
        state: TurnBasedBattleServerState,
        createdAtDate: Date,
        updatedAtDate: Date,
        owner: BattlePlayer,
        joinedPlayers: [BattlePlayer],
        readyPlayers: [BattlePlayer],
        isLocked: Bool,
        turns: [TurnBasedBattleTurn]
    ) {
    
        self.id = id
        
        self.state = state
        
        self.createdAtDate = createdAtDate
        
        self.updatedAtDate = updatedAtDate
        
        self.owner = owner
        
        self.joinedPlayers = joinedPlayers
        
        self.readyPlayers = readyPlayers
        
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
            joinedPlayers: record.joinedPlayers.map(PokemonBattlePlayer.init),
            readyPlayers: record.readyPlayers.map(PokemonBattlePlayer.init),
            isLocked: record.isLocked,
            turns: record.turns.map(PokemonBattleTurn.init)
        )
        
    }
    
}
