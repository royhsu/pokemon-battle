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
            
            record.joineds.removeAll()
            
            record.readys.removeAll()
            
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
    
    public final func appendJoined(
        _ joined: BattleJoined,
        forRecordId id: String
    )
    -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        let player = realm.object(
            ofType: BattlePlayerRealmObject.self,
            forPrimaryKey: joined.player.id
        )!
        
        let joined =
            realm.object(
                ofType: BattleJoinedRealmObject.self,
                forPrimaryKey: joined.id
            )
            ?? BattleJoinedRealmObject(
                value: [
                    "id": joined.id,
                    "player": player
                ]
            )
        
        try! realm.write {
            
            record.joineds.append(joined)

            record.updatedAtDate = Date()

        }

        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!

        // Todo: use better concrete record
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    public final func appendReady(
        _ ready: BattleReady,
        forRecordId id: String
    )
    -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!
        
        let player = realm.object(
            ofType: BattlePlayerRealmObject.self,
            forPrimaryKey: ready.player.id
        )!
        
        let entities: [BattleEntityRealmObject] = ready.entities.map { entity in
            
            let battlePokemon = entity as! BattlePokemon
            
            return
                realm.object(
                    ofType: BattleEntityRealmObject.self,
                    forPrimaryKey: battlePokemon.id
                )
                ?? BattleEntityRealmObject(
                    value: [
                        "id": battlePokemon.id,
                        "attack": battlePokemon.attack,
                        "armor": battlePokemon.armor,
                        "magic": battlePokemon.magic,
                        "magicResistance": battlePokemon.magicResistance,
                        "speed": battlePokemon.speed,
                        "health": battlePokemon.health,
                        "remainingHealth": battlePokemon.remainingHealth
                    ]
                )
            
        }

        let ready =
            realm.object(
                ofType: BattleReadyRealmObject.self,
                forPrimaryKey: ready.id
            )
            ?? BattleReadyRealmObject(
                value: [
                    "id": ready.id,
                    "player": player,
                    "entities": entities
                ]
            )

        try! realm.write {

            record.readys.append(ready)

            record.updatedAtDate = Date()

        }

        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: id
        )!

        // Todo: use better concrete record
        return PokemonBattleRecord(updatedRecord)
        
    }
    
    public final func appendInvolved(
        _ involved: BattleInvolved,
        forCurrentTurnOfRecordId recordId: String
    )
    -> TurnBasedBattleRecord {
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: recordId
        )!
        
        let player = realm.object(
            ofType: BattlePlayerRealmObject.self,
            forPrimaryKey: involved.player.id
        )!
        
        let entities: [BattleEntityRealmObject] = involved.entities.map { entity in
            
            let battlePokemon = entity as! BattlePokemon
            
            return
                realm.object(
                    ofType: BattleEntityRealmObject.self,
                    forPrimaryKey: battlePokemon.id
                )
                ?? BattleEntityRealmObject(
                    value: [
                        "id": battlePokemon.id,
                        "attack": battlePokemon.attack,
                        "armor": battlePokemon.armor,
                        "magic": battlePokemon.magic,
                        "magicResistance": battlePokemon.magicResistance,
                        "speed": battlePokemon.speed,
                        "health": battlePokemon.health,
                        "remainingHealth": battlePokemon.remainingHealth
                    ]
                )
            
        }
        
        let actions: [BattleActionRealmObject] = involved.actions.map { action in
            
            let battleAction = action as! PokemonBattleAction
            
            return
                realm.object(
                    ofType: BattleActionRealmObject.self,
                    forPrimaryKey: battleAction.id
                )
                ?? BattleActionRealmObject(
                    value: [ "id": battleAction.id ]
                )
            
        }

        let involved =
            realm.object(
                ofType: BattleInvolvedRealmObject.self,
                forPrimaryKey: involved.id
            )
            ?? BattleInvolvedRealmObject(
                value: [
                    "id": involved.id,
                    "player": player,
                    "entities": entities,
                    "actions": actions
                ]
            )

        try! realm.write {

            record.turns.last!.involveds.append(involved)

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
