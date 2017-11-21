//
//  PhysicalAttackBattleActionTests.swift
//  PokemonBattleTests
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PhysicalAttackBattleActionTests

import XCTest

@testable import PokemonBattle

internal final class PhysicalAttackBattleActionTests: XCTestCase {
    
    // MARK: Action
    
    internal final func testApplyAction() {
        
        struct StubData {
            
            let battlePokemon: BattlePokemon
            
        }
        
        let stubData = StubData(
            battlePokemon: BattlePokemon(
                identifier: "1",
                pokemon: Pikachu(),
                healthPoint: 100.0
            )
        )
        
        let battleAction = PhysicalAttackBattleAction()
        
        let updatedBattlePokemon = battleAction.applied(battlePokemon: stubData.battlePokemon)
        
        var expectedBattlePokemon = stubData.battlePokemon
        
        expectedBattlePokemon.healthPoint -= 10.0
        
        XCTAssertEqual(
            updatedBattlePokemon.identifier,
            expectedBattlePokemon.identifier
        )
        
        XCTAssertEqual(
            updatedBattlePokemon.healthPoint,
            expectedBattlePokemon.healthPoint
        )
        
    }
    
}
