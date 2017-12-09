//
//  BattlePlayerRealmObject.swift
//  TinyBattleKit
//
//  Created by Roy Hsu on 28/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattlePlayerRealmObject

import Foundation
import RealmSwift

public final class BattlePlayerRealmObject: Object {
    
    // MARK: Property
    
    @objc public dynamic var id: String?
    
    public static override func primaryKey() -> String? { return "id" }
    
}
