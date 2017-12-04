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
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let pikachu = try! PokemonGenerator.make(Pikachu.self)
        
        let charmander = try! PokemonGenerator.make(Charmander.self)
        
        let context = try! PokemonBattleContext(
            battlePokemons: [
                BattlePokemon(pikachu),
                BattlePokemon(charmander)
            ]
        )
        
        let pokemonBattleViewController = PokemonBattleViewController(
            homeBattlePokemonId: pikachu.id,
            homeBattlePokemonImage: #imageLiteral(resourceName: "Pikachu"),
            guestBattlePokemonId: charmander.id,
            guestBattlePokemonImage: #imageLiteral(resourceName: "Charmander"),
            context: context
        )
        
        window.rootViewController = UINavigationController(
            rootViewController: pokemonBattleViewController
        )
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
        
    }

}
