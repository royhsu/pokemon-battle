//
//  Pokemon.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Pokemon

public protocol Pokemon {
    
    var id: String { get }
    
    var attack: Double { get }
    
    var armor: Double { get }
    
    var magic: Double { get }
    
    var magicResistance: Double { get }
    
    var health: Double { get }
    
    init(
        id: String,
        attack: Double,
        armor: Double,
        magic: Double,
        magicResistance: Double,
        health: Double
    )
    
}
