//
//  AnyPokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//
// MARK: - AnyPokemonSkill

import TinyBattleKit

public struct AnyPokemonSkill
<Provider: PokemonSkillProvider>
: PokemonSkill {
    
    private let _name: String
    
    private let _providerType: Provider.Type
    
    public init
    <Skill: PokemonSkill>
    (_ skill: Skill)
    where Skill.Provider == Provider {
        
        self._name = skill.name
        
        self._providerType = skill.providerType
        
    }

    // MARK: PokemonSkill
    
    public var name: String { return _name }
    
    public var providerType: Provider.Type { return _providerType }
    
}
