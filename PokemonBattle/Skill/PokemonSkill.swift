//
//  PokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkill

import TinyBattleKit

public protocol PokemonSkill {
    
    associatedtype Provider = PokemonSkillProvider
    
    var name: String { get }
    
    var providerType: Provider.Type { get }
    
}
