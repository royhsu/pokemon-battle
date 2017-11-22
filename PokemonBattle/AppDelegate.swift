//
//  AppDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Property
    
    public final var window: UIWindow?
    
    public final let basicBattlePokemonDataProvider = BasicBattlePokemonDataProvider(
        homeBattlePokemon: BattlePokemon(
            id: "home",
            pokemon: Pikachu(),
            healthPoint: 100.0
        ),
        guestBattlePokemon: BattlePokemon(
            id: "guest",
            pokemon: Charmander(),
            healthPoint: 100.0
        )
    )

    // MARK: UIApplicationDelegate

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let battleManager = BattleManager()
        
        battleManager.battlePokemonDataProvider = basicBattlePokemonDataProvider
        
        let battleViewController = BattleViewController(
            battleDelegate: battleManager
        )
        
        window.rootViewController = battleViewController
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
        
    }

}
