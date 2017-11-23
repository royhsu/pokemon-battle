//
//  BattleDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleDelegate

public protocol BattleDelegate: class {
    
    var battlePokemonDataProvider: BattlePokemonDataProvider? { get set }
    
    func addBattleAction(
        _ action: BattleAction,
        targetBattlePokemonId id: String
    )

    // If a performing action can't find the target battle pokemon with the given identifier, this action should be skipped.
    // Please make sure to fire up .allBattleAnimationsDidComplete notification name after all battle animations are completed.
    func performAllBattleActions()
    
}

// MARK: - Notification

import Foundation

extension Notification.Name {
    
    public static let allBattleAnimationsDidComplete = Notification.Name(rawValue: "battle-pokemon-delegate.all-battle-animations-did-complete")
    
}
