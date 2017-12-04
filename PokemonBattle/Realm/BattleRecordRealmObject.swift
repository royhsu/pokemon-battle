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
    
    public final var createdAtDate = Date()
    
    public final var updatedAtDate = Date()
    
    public static override func primaryKey() -> String? { return "id" }
    
}
