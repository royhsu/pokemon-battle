//
//  BattlePokemon.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattlePokemon

public struct BattlePokemon {
    
    // MARK: Property
    
    public let id: String
    
    public let pokemon: Pokemon
    
    public var remainingHealthPoint: Double
    
    public init(
        id: String,
        pokemon: Pokemon
    ) {
        
        self.id = id

        self.pokemon = pokemon
        
        self.remainingHealthPoint = pokemon.healthPoint
        
    }
    
}
