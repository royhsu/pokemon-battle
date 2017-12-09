//
//  BattleJoinedRealmObject.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 09/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattlePlayerRealmObject

import Foundation
import RealmSwift

public final class BattleJoinedRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    @objc public dynamic var player: BattlePlayerRealmObject?
    
    public static override func primaryKey() -> String? { return "id" }
    
}
