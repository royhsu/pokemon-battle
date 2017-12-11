//
//  Pokedex.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 11/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Pokedex

public class Pokedex {
    
    // MARK: Property
    
    private final var skillTypeMap: [String: PokemonSkill.Type]
    
    // MARK: Init
    
    public init() {
        
        // Todo: import from config / database
        
        skillTypeMap = [:]
        
    }
    
    // MARK: Skill
    
    public final func registerSkillType(
        _ skillType: PokemonSkill.Type,
        withIdentifier identifier: String
    ) { skillTypeMap[identifier] = skillType }
    
    public final func lookUpSkillType(identifier: String) -> PokemonSkill.Type? { return skillTypeMap[identifier] }
    
}
