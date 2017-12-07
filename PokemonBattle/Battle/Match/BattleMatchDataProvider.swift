//
//  BattleMatchDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMatchDataProvider

import TinyBattleKit

public protocol BattleMatchDataProvider: class {
    
    var currentPlayer: BattlePlayer { get }
    
    func connect(to match: BattleMatch) -> Promise<TurnBasedBattleServer>
    
    func numberOfMatches() -> Int
    
    func match(at index: Int) -> BattleMatch
    
}
