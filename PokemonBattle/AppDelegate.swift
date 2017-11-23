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
    
    // MARK: UIApplicationDelegate

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let battleManager = BattleManager()
        
        battleManager.battlePokemonDataProvider = BasicBattlePokemonDataProvider(
            homeBattlePokemon: BattlePokemon(
                id: "home",
                pokemon: Pikachu()
            ),
            guestBattlePokemon: BattlePokemon(
                id: "guest",
                pokemon: Charmander()
            )
        )
        
        let battleViewController = BattleViewController(
            battleDelegate: battleManager
        )
        
        window.rootViewController = battleViewController
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
        
    }

}
