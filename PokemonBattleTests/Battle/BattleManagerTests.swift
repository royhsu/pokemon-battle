//
//  BattleManagerTests.swift
//  PokemonBattleTests
//
//  Created by Roy Hsu on 21/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleManagerTests

import XCTest

@testable import PokemonBattle

public final class BattleManagerTests: XCTestCase {
    
    // MARK: Property
    
    public final var battleManager: BattleManager?
    
    // MARK: Set Up
    
    public final override func setUp() {
        
        super.setUp()
        
        self.battleManager = BattleManager()
        
    }
    
    public final override func tearDown() {
        
        super.tearDown()
        
        battleManager = nil
        
    }
    
    // MARK: Battle Action
    
    public final func testPerformAllBattleActions() {
        
        struct StubData {
            
            let battlePokemon: BattlePokemon
            
        }
        
        let stubData = StubData(
            battlePokemon: BattlePokemon(
                id: "1",
                pokemon: Pikachu(),
                healthPoint: 100.0
            )
        )
        
        guard
            let battleManager = battleManager
        else {
            
            XCTFail("battleManager is required.")
            
            return
            
        }
        
        let battlePokemonDataProvider = StubBattlePokemonDataProvider(
            stubBattlePokemons: [
                stubData.battlePokemon
            ]
        )
        
        battleManager.battlePokemonDataProvider = battlePokemonDataProvider
        
        let battleAction = PhysicalAttackBattleAction(attackPoint: stubData.battlePokemon.pokemon.attackPoint, animation: nil)
        
        let battlePokemonId = stubData.battlePokemon.id
        
        battleManager.addBattleAction(
            battleAction,
            targetBattlePokemonId: battlePokemonId
        )
        
        XCTAssertEqual(
            battleManager.actions
                .filter { $0.battlePokemonId == battlePokemonId }
                .count,
            1
        )
        
        battleManager.performAllBattleActions()
        
        let updatedBattlePokemon = battleManager.battlePokemonDataProvider?.battlePokemon(id: battlePokemonId)
        
        let expectedBattlePokemon = battleAction.apply(on: stubData.battlePokemon)
        
        XCTAssertEqual(
            updatedBattlePokemon?.id,
            expectedBattlePokemon.id
        )
        
        XCTAssertEqual(
            updatedBattlePokemon?.healthPoint,
            expectedBattlePokemon.healthPoint
        )
        
    }
    
}
