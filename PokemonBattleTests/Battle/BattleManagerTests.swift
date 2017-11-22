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
            
            let homeBattlePokemon: BattlePokemon
            
            let guestBattlePokemon: BattlePokemon
            
        }
        
        let stubData = StubData(
            homeBattlePokemon: BattlePokemon(
                id: "1",
                pokemon: Pikachu(),
                healthPoint: 100.0
            ),
            guestBattlePokemon: BattlePokemon(
                id: "2",
                pokemon: Charmander(),
                healthPoint: 100.0
            )
        )
        
        guard
            let battleManager = battleManager
        else {
            
            XCTFail("battleManager is required.")
            
            return
            
        }
        
        let battlePokemonDataProvider = BasicBattlePokemonDataProvider(
            homeBattlePokemon: stubData.homeBattlePokemon,
            guestBattlePokemon: stubData.guestBattlePokemon
        )
        
        battleManager.battlePokemonDataProvider = battlePokemonDataProvider
        
        let battleAction = PhysicalAttackBattleAction(
            attackPoint: stubData.homeBattlePokemon.pokemon.attackPoint,
            battleFieldScene: nil
        )
        
        battleManager.addBattleAction(
            battleAction,
            targetBattlePokemonId: stubData.guestBattlePokemon.id
        )
        
        XCTAssertEqual(
            battleManager.actions
                .filter { $0.battlePokemonId == stubData.guestBattlePokemon.id }
                .count,
            1
        )
        
        battleManager.performAllBattleActions()
        
        let updatedBattlePokemon = battlePokemonDataProvider.guestBattlePokemon
        
        let expectedBattlePokemon = battleAction.apply(on: stubData.guestBattlePokemon)
        
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
