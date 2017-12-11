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
    
    public let speed: Double
    
    public let health: Double
    
    public var remainingHealth: Double
    
    public let skills: [PokemonSkill]
    
    // MARK: Init
    
    public init(
        id: String,
        attack: Double,
        armor: Double,
        magic: Double,
        magicResistance: Double,
        speed: Double,
        health: Double,
        remainingHealth: Double,
        skills: [PokemonSkill]
    ) {
     
        self.id = id
        
        self.attack = attack
        
        self.armor = armor
        
        self.magic = magic
        
        self.magicResistance = magicResistance
        
        self.health = health
        
        self.speed = speed
        
        self.remainingHealth = remainingHealth
        
        self.skills = skills
        
    }
    
}

// MARK: - Realm

public extension BattlePokemon {
    
    public init(_ entity: BattleEntityRealmObject) {
        
        self.init(
            id: entity.id!,
            attack: entity.attack,
            armor: entity.armor,
            magic: entity.magic,
            magicResistance: entity.magicResistance,
            speed: entity.speed,
            health: entity.health,
            remainingHealth: entity.remainingHealth,
            skills: entity.skills.map(PokemonSkill.init)
        )
        
    }
    
}
