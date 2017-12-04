//
//  BattleTurnRealmObject.swift
//  TinyBattleKit
//
//  Created by Roy Hsu on 27/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleTurnRealmObject

import Foundation
import RealmSwift

public final class BattleTurnRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    public final var invovledPlayers = List<BattlePlayerRealmObject>()
    
    public static override func primaryKey() -> String? { return "id" }
    
}
