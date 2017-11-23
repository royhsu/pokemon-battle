//
//  Charmander.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Charmander

public struct Charmander: Pokemon {
    
    // MARK: Property
    
    public let attackPoint = 10.0
    
    public let magicPowerPoint = 8.0
    
    public let healthPoint = 46.0
    
    public let skillTypes: [PokemonSkill.Type] = [
        PhysicalAttackPokemonSkill.self,
        WaggingTailPokemonSkill.self,
        FirePokemonSkill.self
    ]
    
}
