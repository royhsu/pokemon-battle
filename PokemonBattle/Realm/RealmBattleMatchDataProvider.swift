//
//  RealmBattleMatchDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - RealmBattleMatchDataProvider

import RealmSwift

public final class RealmBattleMatchDataProvider: BattleMatchDataProvider {
    
    // MARK: Property
    
    public final unowned let realm: Realm
    
    private final var records: Results<BattleRecordRealmObject>
    
    private final var notificationToken: NotificationToken?
    
    // MARK: Init
    
    public init(realm: Realm) {
        
        self.realm = realm
        
        self.records = realm
            .objects(BattleRecordRealmObject.self)
            .filter("isLocked = false")
        
        self.notificationToken = records.observe { change in
        
            switch change {
                
            case .initial: break
                
            case .update:
                
                self.records = realm
                    .objects(BattleRecordRealmObject.self)
                    .filter("isLocked = false")
                
            case .error(let error):
                
                print("\(error)")
                
            }
        
        }
        
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
