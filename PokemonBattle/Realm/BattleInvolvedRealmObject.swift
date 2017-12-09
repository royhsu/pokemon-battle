//
//  BattleInvolvedRealmObject.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 09/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleInvolvedRealmObject

import Foundation
import RealmSwift

public final class BattleInvolvedRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    @objc public dynamic var player: BattlePlayerRealmObject?
    
    public final let entities = List<BattleEntityRealmObject>()
    
    public final let actions = List<BattleActionRealmObject>()
    
    public static override func primaryKey() -> String? { return "id" }
    
}

