//
//  BattlePokemon.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattlePokemon

import TinyBattleKit

public struct BattlePokemon: BattleEntity {
    
    // MARK: Property
    
    public let id: String
    
    public let attack: Double
    
    public let armor: Double
    
    public let magic: Double
    
    public let magicResistance: Double
    
    public let health: Double
    
    public var remainingHealth: Double
    
    // MARK: Init
    
    public init(
        id: String,
        attack: Double,
        armor: Double,
        magic: Double,
        magicResistance: Double,
        health: Double,
        remainingHealth: Double
    ) {
     
        self.id = id
        
        self.attack = attack
        
        self.armor = armor
        
        self.magic = magic
        
        self.magicResistance = magicResistance
        
        self.health = health
        
        self.remainingHealth = remainingHealth
        
    }
    
}
