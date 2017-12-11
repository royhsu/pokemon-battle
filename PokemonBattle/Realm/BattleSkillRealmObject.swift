//
//  BattleSkillRealmObject.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 11/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleSkillRealmObject

import Foundation
import RealmSwift

public final class BattleSkillRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var name: String?
    
    public static override func primaryKey() -> String? { return "name" }
    
}
