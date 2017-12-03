//
//  BattlePokemonDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 22/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattlePokemonDataProvider

public protocol BattlePokemonDataProvider: class {
    
    var homeBattlePokemon: BattlePokemon? { get }
    
    var guestBattlePokemon: BattlePokemon? { get }
    
    func replaceBattlePokemon(
        id: String,
        with newBattlePokemon: BattlePokemon
    )
    
    func battlePokemon(id: String) -> BattlePokemon?
    
}

// MARK: - BattleMenuDataProvider

extension BattlePokemonDataProvider
where Self: BattleMenuDataProvider {
    
    public func numberOfPokemonSkills() -> Int {
        
//        return homeBattlePokemon?.pokemon.skillTypes.count ?? 0
        fatalError()
        
    }
    
    public func titleForPokemonSkill(at index: Int) -> String? {
        
//        guard
//            let skillTypes = homeBattlePokemon?.pokemon.skillTypes,
//            index < skillTypes.count
//        else { return nil }
//
//        return skillTypes[index].name
        
        fatalError()
        
    }
    
}

// MARK: - Notification

import Foundation

extension Notification.Name {
    
    public static let battlePokemonDataProviderDataDidChange = Notification.Name(rawValue: "battle-pokemon-data-provider.data-did-change")
    
}
