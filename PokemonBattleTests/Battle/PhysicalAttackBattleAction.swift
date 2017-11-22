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
                id: "1",
                pokemon: Pikachu()
            )
        )
        
        let battleAction = PhysicalAttackBattleAction(
            attackPoint: stubData.battlePokemon.pokemon.attackPoint,
            battleFieldScene: nil
        )
        
        let updatedBattlePokemon = battleAction.apply(on: stubData.battlePokemon)
        
        var expectedBattlePokemon = stubData.battlePokemon
        
        expectedBattlePokemon.remainingHealthPoint -= stubData.battlePokemon.pokemon.attackPoint
        
        XCTAssertEqual(
            updatedBattlePokemon.id,
            expectedBattlePokemon.id
        )
        
        XCTAssertEqual(
            updatedBattlePokemon.remainingHealthPoint,
            expectedBattlePokemon.remainingHealthPoint
        )
        
    }
    
}
