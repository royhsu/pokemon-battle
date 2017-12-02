//
//  BattleSystemTests.swift
//  PokemonBattleTests
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleSystemTests

import TinyBattleKit
import XCTest

@testable import PokemonBattle

internal final class BattleSystemTests: XCTestCase {
    
    internal final func testSystem() {
        
        let system = BattleSystem()
        
        let pikachu = BattleEntity(
            id: UUID().uuidString,
            attack: 7.0,
            armor: 2.0,
            magic: 10.0,
            magicResistance: 3.0,
            health: 45.0,
            remainingHealth: 45.0
        )
        
        let charmander = BattleEntity(
            id: UUID().uuidString,
            attack: 8.0,
            armor: 2.0,
            magic: 11.0,
            magicResistance: 3.0,
            health: 43.0,
            remainingHealth: 43.0
        )
        
        let initialContext = try! BattleContext(
            entities: [ pikachu, charmander ]
        )

        let resultContext = system
            .respond(
                to: .lightningSkill(
                    sourceId: pikachu.id,
                    destinationId: charmander.id
                )
            )
            .run(with: initialContext)

        XCTAssertEqual(
            resultContext.entity(id: charmander.id)?.remainingHealth,
            34.0
        )
        
    }
    
}
