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
            
            if let involveds = record.turns.last?.involveds {
            
                self.realm.delete(involveds)
                
            }
            
            self.realm.delete(record.joineds)
            
            self.realm.delete(record.readys)
            
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
        
        // Todo: unify coding style
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
            
            let entity = realm.object(
                    ofType: BattleEntityRealmObject.self,
                    forPrimaryKey: battlePokemon.id
                )
                ?? BattleEntityRealmObject(
                    value: [ "id": battlePokemon.id ]
                )
            
            try! realm.write {
            
                entity.attack = battlePokemon.attack
                
                entity.armor = battlePokemon.armor
                
                entity.magic = battlePokemon.magic
                
                entity.magicResistance = battlePokemon.magicResistance
                
                entity.speed = battlePokemon.speed
                
                entity.health = battlePokemon.health
                
                entity.remainingHealth = battlePokemon.remainingHealth
                
                entity.skills = List()
                
                battlePokemon.skills.forEach { skill in
                    
                    let skill =
                        realm.object(
                            ofType: BattleSkillRealmObject.self,
                            forPrimaryKey: skill.name
                        )
                        ?? BattleSkillRealmObject(
                            value: [ "name": skill.name ]
                        )
                    
                    entity.skills.append(skill)
                    
                }
                
            }
            
            return entity
            
        }

        // Todo: unify coding style
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
        
        let recordObject = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: recordId
        )!
        
        let playerObject = realm.object(
            ofType: BattlePlayerRealmObject.self,
            forPrimaryKey: involved.player.id
        )!
        
        let involvedObject =
            realm.object(
                ofType: BattleInvolvedRealmObject.self,
                forPrimaryKey: involved.id
            )
            ?? BattleInvolvedRealmObject(
                value: [ "id": involved.id ]
            )
        
        try! realm.write {
            
            involvedObject.player = playerObject
        
            involvedObject.entities = List()
        
            involvedObject.actions = List()
            
            involved.entities.forEach { entity in
            
                let battlePokemon = entity as! BattlePokemon
            
                let entityObject =
                    realm.object(
                        ofType: BattleEntityRealmObject.self,
                        forPrimaryKey: battlePokemon.id
                    )
                    ?? BattleEntityRealmObject(
                        value: [ "id": battlePokemon.id ]
                    )
                
                entityObject.attack = battlePokemon.attack
                
                entityObject.armor = battlePokemon.armor
                
                entityObject.magic = battlePokemon.magic
                
                entityObject.magicResistance = battlePokemon.magicResistance
                
                entityObject.speed = battlePokemon.speed
                
                entityObject.health = battlePokemon.health
                
                entityObject.remainingHealth = battlePokemon.remainingHealth
                
                entityObject.skills = List()
                
                battlePokemon.skills.forEach { skill in
                    
                    let skillObject =
                        realm.object(
                            ofType: BattleSkillRealmObject.self,
                            forPrimaryKey: skill.name
                        )
                        ?? BattleSkillRealmObject(
                            value: [ "name": skill.name ]
                        )
                    
                    entityObject.skills.append(skillObject)
                    
                }
                
                involvedObject.entities.append(entityObject)
                
            }
            
            involved.actions.forEach { action in
        
                let battleAction = action as! PokemonBattleAction
            
                let actionObject =
                    realm.object(
                        ofType: BattleActionRealmObject.self,
                        forPrimaryKey: battleAction.id
                    )
                    ?? BattleActionRealmObject(
                        value: [ "id": battleAction.id ]
                    )
            
                let skillName = battleAction.skill.name
                
                let skillObject =
                    realm.object(
                        ofType: BattleSkillRealmObject.self,
                        forPrimaryKey: skillName
                    )
                    ?? BattleSkillRealmObject(
                        value: [ "name": skillName ]
                    )
                
                actionObject.skill = skillObject
                
                actionObject.priority = battleAction.priority
            
                actionObject.source = realm.object(
                    ofType: BattleEntityRealmObject.self,
                    forPrimaryKey: battleAction.source.id
                )!
            
                battleAction.destinations.forEach { destination in
                    
                    actionObject.destinations.append(
                        realm.object(
                            ofType: BattleEntityRealmObject.self,
                            forPrimaryKey: destination.id
                        )!
                    )
                    
                }
            
                involvedObject.actions.append(actionObject)
                
            }
         
            recordObject.turns.last!.involveds.append(involvedObject)
            
            recordObject.updatedAtDate = Date()
            
        }

        let updatedRecord = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: recordId
        )!

        // Todo: use better concrete player
        return PokemonBattleRecord(updatedRecord)
        
    }
    
}
