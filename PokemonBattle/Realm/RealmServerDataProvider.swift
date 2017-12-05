//
//  RealmServerDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 02/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - RealmServerDataProvider

import RealmSwift
import TinyBattleKit

public final class RealmServerDataProvider: TurnBasedBattleServerDataProvider {
    
    // MARK: Property
    
    public final unowned let realm: Realm
    
    // MARK: Init
    
    public init(realm: Realm) { self.realm = realm }
    
    // MARK: TurnBasedBattleServerDataProvider
    
    public final func fetchPlayer(id: String) -> BattlePlayer? {
        
        guard
            let player = realm.object(
                ofType: BattlePlayerRealmObject.self,
                forPrimaryKey: id
            )
        else { return nil }
        
        return PokemonBattlePlayer(player)
        
    }
    
    public final func fetchRecord(id: String) -> TurnBasedBattleRecord? {
        
        guard
            let record = realm.object(
                ofType: BattleRecordRealmObject.self,
                forPrimaryKey: id
            )
        else { return nil }
        
        return PokemonBattleRecord(record)
        
    }
    
    // Todo: optional return type
    public final func addNewTurnForRecord(id: String) -> TurnBasedBattleRecord {
        
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
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    // Todo: optional return type
    public final func addInvolvedPlayer(
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
            
        }
        
        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: recordId
        )!
        
        return PokemonBattleRecord(updatedRecord)
        
    }
    
}
