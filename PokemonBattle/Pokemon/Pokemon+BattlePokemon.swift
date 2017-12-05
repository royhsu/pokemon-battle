//
//  Pokemon+BattlePokemon.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattlePokemon

public extension BattlePokemon {
    
    public init(
        _ pokemon: Pokemon,
        role: BattlePokemonRole
    ) {
        
        self.init(
            id: pokemon.id,
            attack: pokemon.attack,
            armor: pokemon.armor,
            magic: pokemon.magic,
            magicResistance: pokemon.magicResistance,
            speed: pokemon.speed,
            health: pokemon.health,
            remainingHealth: pokemon.health,
            role: role
        )
        
    }
    
}
