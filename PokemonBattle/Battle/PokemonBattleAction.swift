//
//  PokemonBattleAction.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 09/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattlePlayer

import TinyBattleKit

public struct PokemonBattleAction: BattleAction {
    
    // MARK: Property
    
    public let id: String
    
    // MARK: Init
    
    public init(id: String) { self.id = id }
    
}

// MARK: - Realm

public extension PokemonBattleAction {
    
    public init(_ action: BattleActionRealmObject) {
        
        self.init(id: action.id!)
        
    }
    
}
