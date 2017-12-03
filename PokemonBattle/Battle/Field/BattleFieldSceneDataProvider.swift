//
//  BattleFieldSceneDataProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleFieldSceneDataProvider

import UIKit

public protocol BattleFieldSceneDataProvider: class {
    
    var homeBattlePokemon: BattlePokemon { get }
    
    var homeBattlePokemonImage: UIImage { get }
    
    var guestBattlePokemon: BattlePokemon { get }
    
    var guestBattlePokemonImage: UIImage { get }
    
}
