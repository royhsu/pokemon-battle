//
//  BattleMatchDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMatchDataProvider

public protocol BattleMatchDataProvider: class {
    
    func numberOfMatches() -> Int
    
    func match(at index: Int) -> BattleMatch
    
}
