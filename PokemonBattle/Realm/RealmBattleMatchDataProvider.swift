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

public final class RealmBattleMatchDataProvider: BattleMatchDataProvider {
    
    // MARK: Property
    
    public final unowned let realm: Realm
    
    private final var records: Results<BattleRecordRealmObject>
    
    private final var notificationToken: NotificationToken?
    
    // MARK: Init
    
    public init(realm: Realm) {
        
        self.realm = realm
        
        self.records = RealmBattleMatchDataProvider.fetchRecords(with: realm)
        
        self.notificationToken = records.observe { change in
        
            switch change {
                
            case .initial: break
                
            case .update:
                
                self.records = RealmBattleMatchDataProvider.fetchRecords(with: realm)
                
            case .error(let error):
                
                print("\(error)")
                
            }
        
        }
        
    }
    
    fileprivate static func fetchRecords(with realm: Realm) -> Results<BattleRecordRealmObject> {
        
        let serverOnlineDate = Date().addingTimeInterval(-10.0)
        
        return realm
            .objects(BattleRecordRealmObject.self)
            .filter(
                "(isLocked = false) AND (updatedAtDate >= %@)",
                serverOnlineDate
            )
        
    }
    
    deinit { notificationToken?.invalidate() }
    
    // MARK: BattleMatchDataProvider
    
    public final func numberOfMatches() -> Int { return records.count }
    
    public final func match(at index: Int) -> BattleMatch {
    
        return PokemonBattleRecord(
            records[index]
        )
        
    }
    
}
