//
//  BattleRecordRealmObject.swift
//  TinyBattleKit
//
//  Created by Roy Hsu on 27/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleRecordRealmObject

import Foundation
import RealmSwift

public final class BattleRecordRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    public final var turns = List<BattleTurnRealmObject>()
    
    @objc public dynamic var createdAtDate = Date()
    
    @objc public dynamic var updatedAtDate = Date()
    
    @objc public dynamic var owner: BattlePlayerRealmObject?
    
    @objc public dynamic var isLocked: Bool = false
    
    public static override func primaryKey() -> String? { return "id" }
    
}
