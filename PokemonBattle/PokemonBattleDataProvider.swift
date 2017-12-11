//
//  PokemonBattleDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 22/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonBattleDataProvider

public protocol PokemonBattleDataProvider: class {
    
    var homeBattlePokemon: BattlePokemon { get }
    
    var guestBattlePokemon: BattlePokemon { get }
    
}

// MARK: - BattleMenuDataProvider

extension PokemonBattleDataProvider
where Self: BattleMenuTableViewControllerDataSource {
    
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
