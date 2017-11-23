//
//  BattleMenuDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMenuDataProvider

public protocol BattleMenuDataProvider: class {
    
    func numberOfPokemonSkills() -> Int
    
    func titleForPokemonSkill(at index: Int) -> String?
    
}
