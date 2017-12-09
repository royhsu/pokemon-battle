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
import TinyBattleKit

public final class BattleRecordRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    @objc public dynamic var state = TurnBasedBattleServerState.end.rawValue
    
    @objc public dynamic var createdAtDate = Date()
    
    @objc public dynamic var updatedAtDate = Date()
    
    @objc public dynamic var owner: BattlePlayerRealmObject?
    
    public final var joineds = List<BattleJoinedRealmObject>()
    
    public final var readys = List<BattleReadyRealmObject>()
    
    @objc public dynamic var isLocked: Bool = false
    
    public final var turns = List<BattleTurnRealmObject>()
    
    public static override func primaryKey() -> String? { return "id" }
    
}
