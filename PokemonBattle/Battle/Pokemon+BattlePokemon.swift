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
        id: String,
        pokemon: Pokemon
    ) {
        
        self.init(
            id: id,
            attack: pokemon.attack,
            armor: pokemon.armor,
            magic: pokemon.magic,
            magicResistance: pokemon.magicResistance,
            speed: pokemon.speed,
            health: pokemon.health,
            remainingHealth: pokemon.health
        )
        
    }
    
}
