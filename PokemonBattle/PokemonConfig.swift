//
//  PokemonConfig.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonConfig

import Foundation

public struct PokemonConfig: Codable {
    
    public struct Attribute: Codable {
        
        // MARK: Property
        
        public let maximum: Double
        
        public let minimum: Double
        
        // MARK: Random
        
        public func random() -> Double {
            
            let factor = 1000.0
            
            let upperBound = Int(maximum * factor)
            
            let lowerBound = Int(minimum * factor)
            
            let value =
                lowerBound
                + Int(
                    arc4random_uniform(
                        UInt32(upperBound - lowerBound)
                    )
                )
            
            return Double(value) / factor
            
        }
        
    }
    
    // MARK: Property
    
    public let attack: Attribute
    
    public let armor: Attribute
    
    public let magic: Attribute
    
    public let magicResistance: Attribute
    
    public let health: Attribute
    
    // MARK: Init
    
    public init(
        attack: Attribute,
        armor: Attribute,
        magic: Attribute,
        magicResistance: Attribute,
        health: Attribute
    ) {
        
        self.attack = attack
        
        self.armor = armor
        
        self.magic = magic
        
        self.magicResistance = magicResistance
        
        self.health = health
        
    }
    
}
