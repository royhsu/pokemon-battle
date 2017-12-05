//
//  Pikachu.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Pikachu

public struct Pikachu: Pokemon {
    
    // MARK: Property
    
    public let id: String
    
    public let attack: Double
    
    public let armor: Double
    
    public let magic: Double
    
    public let magicResistance: Double
    
    public let speed: Double
    
    public let health: Double
    
    // MARK: Init
    
    public init(
        id: String,
        attack: Double,
        armor: Double,
        magic: Double,
        magicResistance: Double,
        speed: Double,
        health: Double
    ) {
    
        self.id = id
        
        self.attack = attack
        
        self.armor = armor
        
        self.magic = magic
        
        self.magicResistance = magicResistance
        
        self.speed = speed
        
        self.health = health
        
    }
    
}
