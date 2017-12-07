//
//  RealmBattleMatchDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - RealmBattleMatchDataProvider

import Foundation
import RealmSwift
import TinyBattleKit

public final class RealmBattleMatchDataProvider: BattleMatchDataProvider {
    
    // MARK: Property
    
    public final let realm: Realm
    
    public final let serverDataProvider: TurnBasedBattleServerDataProvider
    
    public final let currentPlayer: BattlePlayer
    
    private final var records: Results<BattleRecordRealmObject>
    
    private final var notificationToken: NotificationToken?
    
    // MARK: Init
    
    public init(
        realm: Realm,
        serverDataProvider: TurnBasedBattleServerDataProvider,
        currentPlayer: BattlePlayer
    ) {
        
        self.realm = realm
        
        self.serverDataProvider = serverDataProvider
        
        self.records = type(of: self).fetchRecords(with: realm)
        
        self.currentPlayer = currentPlayer
        
        self.notificationToken = records.observe { change in
        
            switch change {
                
            case .initial: break
                
            case .update:
                
                self.records = type(of: self).fetchRecords(with: realm)
                
            case .error(let error):
                
                print("\(error)")
                
            }
        
        }
        
    }
    
    public static func fetchRecords(with realm: Realm) -> Results<BattleRecordRealmObject> {
        
//        let serverOnlineDate = Date().addingTimeInterval(-10.0)
        
        return realm
            .objects(BattleRecordRealmObject.self)
            .filter("isLocked = false")
//            .filter(
//                "(isLocked = false) AND (updatedAtDate >= %@)",
//                serverOnlineDate
//            )
        
    }
    
    deinit { notificationToken?.invalidate() }
    
    // MARK: BattleMatchDataProvider
    
    public final func makeMatch() -> BattleMatch {
        
        // Todo: create new match
        
        let record = realm.object(
            ofType: BattleRecordRealmObject.self,
            forPrimaryKey: "31CFED91-78A4-4FB6-9A0A-A93F88F692A8"
        )!
        
        return PokemonBattleRecord(record)
        
    }
    
    public final func makeServer(for match: BattleMatch) -> TurnBasedBattleServer {
        
        let record = match as! PokemonBattleRecord
        
        return TurnBasedBattleServer(
            dataProvider: serverDataProvider,
            player: currentPlayer,
            record: record
        )
        
    }
    
    public final func numberOfMatches() -> Int { return records.count }
    
    public final func match(at index: Int) -> BattleMatch {
    
        return PokemonBattleRecord(
            records[index]
        )
        
    }
    
}
