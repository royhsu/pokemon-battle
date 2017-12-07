//
//  RealmBattleServerDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - ObservationToken

extension NotificationToken: ObservationToken { }

// MARK: - RealmBattleServerDataProvider

import RealmSwift
import TinyBattleKit

public final class RealmBattleServerDataProvider: TurnBasedBattleServerDataProvider {
    
    // MARK: Property
    
    public final unowned let realm: Realm
    
    // MARK: Init
    
    public init(realm: Realm) { self.realm = realm }
    
    // MARK: TurnBasedBattleServerDataProvider
    
    public final func observeRecord(
        id: String,
        handler: @escaping ObserveRecordHandler
    )
    -> ObservationToken? {
        
        guard
            let record = realm.object(
                ofType: BattleRecordRealmObject.self,
                forPrimaryKey: id
            )
        else { return nil }
        
        return record.observe { [weak self] change in
            
            guard
                let strongSelf = self,
                let updatedRecord = strongSelf.realm.object(
                    ofType: BattleRecordRealmObject.self,
                    forPrimaryKey: id
                )
            else { return }
            
            handler(
                PokemonBattleRecord(updatedRecord)
            )
            
        }
        
    }
    
    public final func fetchPlayer(id: String) -> BattlePlayer? {
        
        guard
            let player = realm.object(
                ofType: BattlePlayerRealmObject.self,
                forPrimaryKey: id
            )
        else { return nil }
        
        // Todo: use better concrete player
        return PokemonBattlePlayer(player)
        
    }
    
    public final func fetchRecord(id: String) -> TurnBasedBattleRecord? {
        
        guard
            let record = realm.object(
                ofType: BattleRecordRealmObject.self,
                forPrimaryKey: id
            )
        else { return nil }
        
        // Todo: use better concrete record
        return PokemonBattleRecord(record)
        
    }
    
    public final func setState(
        _ state: TurnBasedBattleServerState,
        forRecordId id: String
    )
    -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        try! realm.write {
            
            record.state = state.rawValue
            
            record.updatedAtDate = Date()
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        // Todo: use better concrete record
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    public final func appendTurnForRecord(id: String) -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        try! realm.write {
            
            record.turns.append(
                BattleTurnRealmObject(
                    value: [ "id": UUID().uuidString ]
                )
            )
            
            record.updatedAtDate = Date()
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        // Todo: use better concrete record
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    public final func resetJoinedAndReadyPlayersForRecord(id: String) -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        try! realm.write {
            
            record.joinedPlayers.removeAll()
            
            record.readyPlayers.removeAll()
            
            // Todo: should remove involved players for the current turn?
            
            record.updatedAtDate = Date()
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        // Todo: use better concrete record
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    public final func appendJoinedPlayer(
        _ player: BattlePlayer,
        forRecordId id: String
    )
    -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        let player = realm.object(
            ofType: BattlePlayerRealmObject.self,
            forPrimaryKey: player.id
        )!
        
        try! realm.write {
            
            record.joinedPlayers.append(player)
            
            record.updatedAtDate = Date()
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        // Todo: use better concrete record
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    public final func appendReadyPlayer(
        _ player: BattlePlayer,
        forRecordId id: String
    )
    -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        let player = realm.object(
            ofType: BattlePlayerRealmObject.self,
            forPrimaryKey: player.id
        )!
        
        try! realm.write {
            
            record.readyPlayers.append(player)
            
            record.updatedAtDate = Date()
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        // Todo: use better concrete record
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    public final func appendInvolvedPlayer(
        _ player: BattlePlayer,
        forCurrentTurnOfRecordId recordId: String
    )
    -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: recordId
        )!
        
        let player = realm.object(
            ofType: BattlePlayerRealmObject.self,
            forPrimaryKey: player.id
        )!
        
        try! realm.write {
            
            record.turns.last!.invovledPlayers.append(player)
            
            record.updatedAtDate = Date()
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: recordId
        )!
        
        // Todo: use better concrete player
        return PokemonBattleRecord(updatedRecord)
        
    }
    
}
