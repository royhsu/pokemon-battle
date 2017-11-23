//
//  PokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkill

public protocol PokemonSkill {
    
    static var name: String { get }
    
    static var battleActionType: BattleAction.Type { get }
    
}
