//
//  BattleActionRealmObject.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 08/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleActionRealmObject

import Foundation
import RealmSwift

public final class BattleActionRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    @objc public dynamic var skill: BattleSkillRealmObject?
    
    @objc public dynamic var priority: Double = 0.0
    
    @objc public dynamic var source: BattleEntityRealmObject?
    
    public final var destinations = List<BattleEntityRealmObject>()
    
    public static override func primaryKey() -> String? { return "id" }

}
