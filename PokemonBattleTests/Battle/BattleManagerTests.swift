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
                identifier: "1",
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
        
        battleManager.battlePokemons.append(
            stubData.battlePokemon
        )
        
        do {
            
            let identifier = stubData.battlePokemon.identifier
            
            let battleAction = PhysicalAttackBattleAction()
            
            try battleManager.addBattleAction(
                battleAction,
                toPokemonWithIdentifier: identifier
            )
            XCTAssertNotNil(battleManager.battleMap[identifier])
            
            battleManager.performAllBattleActions()
            
            guard
                let index = battleManager.battlePokemons.index(
                    where: { $0.identifier == stubData.battlePokemon.identifier }
                )
            else {
                
                XCTFail("Battle pokemon not found.")
                
                return
                
            }
            
            let updatedBattlePokemon = battleManager.battlePokemons[index]
            
            let expectedBattlePokemon = battleAction.applied(battlePokemon: stubData.battlePokemon)
            
            XCTAssertEqual(
                updatedBattlePokemon.identifier,
                expectedBattlePokemon.identifier
            )
            
            XCTAssertEqual(
                updatedBattlePokemon.healthPoint,
                expectedBattlePokemon.healthPoint
            )
            
        }
        catch { XCTFail("\(error)") }
        
    }
    
}
