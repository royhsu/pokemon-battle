//
//  BattleEntityRealmObject.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 07/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleEntityRealmObject

import Foundation
import RealmSwift

public final class BattleEntityRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    @objc public dynamic var attack = 0.0
    
    @objc public dynamic var armor = 0.0
    
    @objc public dynamic var magic = 0.0
    
    @objc public dynamic var magicResistance = 0.0
    
    @objc public dynamic var speed = 0.0
    
    @objc public dynamic var health = 0.0
    
    @objc public dynamic var remainingHealth = 0.0
    
    @objc public dynamic var role = 0.0
    
    public static override func primaryKey() -> String? { return "id" }
    
}
