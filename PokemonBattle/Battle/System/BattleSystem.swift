//
//  BattleSystem.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleSystem

import TinyBattleKit

public final class BattleSystem: TurnBasedBattle {
    
    public typealias Provider = AnyBattleActionProvider<BattleContext>
    
    // MARK: Property
    
    public final var actionProviders: [Provider] = []
    
}
