//
//  PokemonGenerator.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonGeneratorError

public enum PokemonGeneratorError: Error {
    
    // MARK: Case
    
    case propertyListNotFound(name: String)
    
}

// MARK: - PokemonGenerator

import Foundation

public struct PokemonGenerator {
    
    // MARK: Property List
    
    public static func make<P: Pokemon>(
        _ type: P.Type,
        propertyListName: String? = nil
    )
    throws -> P {

        let fileName = propertyListName ?? String(describing: type.self)

        guard
            let configUrl = Bundle.main.url(
                forResource: fileName,
                withExtension: "plist"
            )
        else {

            let error: PokemonGeneratorError = .propertyListNotFound(name: fileName)

            throw error

        }

        let data = try Data(contentsOf: configUrl)
        
        let decoder = PropertyListDecoder()
        
        let config = try decoder.decode(
            PokemonConfig.self,
            from: data
        )
        
        let pokemon = P(
            id: UUID().uuidString,
            attack: config.attack.random(),
            armor: config.armor.random(),
            magic: config.magic.random(),
            magicResistance: config.magicResistance.random(),
            health: config.health.random()
        )
        
        return pokemon

    }
    
}
