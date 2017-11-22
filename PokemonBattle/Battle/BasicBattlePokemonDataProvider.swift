//
//  BasicBattlePokemonDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 22/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BasicBattlePokemonDataProvider

import Foundation

public final class BasicBattlePokemonDataProvider: BattlePokemonDataProvider {
    
    // MARK: Property
    
    public final var homeBattlePokemon: BattlePokemon
    
    public final var guestBattlePokemon: BattlePokemon
    
    // MARK: Init
    
    public init(
        homeBattlePokemon: BattlePokemon,
        guestBattlePokemon: BattlePokemon
    ) {
        
        self.homeBattlePokemon = homeBattlePokemon
        
        self.guestBattlePokemon = guestBattlePokemon
        
    }
    
    public final func replaceBattlePokemon(
        id: String,
        with newBattlePokemon: BattlePokemon
    ) {
       
        if id == homeBattlePokemon.id {
            
            homeBattlePokemon = newBattlePokemon
            
        }
        else if id == guestBattlePokemon.id {
            
            guestBattlePokemon = newBattlePokemon
            
        }
        
        NotificationCenter.default.post(
            name: .battlePokemonDataProviderDataDidChange,
            object: nil
        )
        
    }
    
    public final func battlePokemon(id: String) -> BattlePokemon? {
        
        if id == homeBattlePokemon.id {
            
            return homeBattlePokemon
            
        }
        else if id == guestBattlePokemon.id {
            
            return guestBattlePokemon
            
        }
        else { return nil }
        
        
    }
    
}
