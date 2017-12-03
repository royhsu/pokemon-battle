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
        
        let pikachu = BattlePokemon(
            id: UUID().uuidString,
            attack: 7.0,
            armor: 2.0,
            magic: 10.0,
            magicResistance: 3.0,
            health: 45.0,
            remainingHealth: 45.0
        )

        let charmander = BattlePokemon(
            id: UUID().uuidString,
            attack: 8.0,
            armor: 2.0,
            magic: 11.0,
            magicResistance: 3.0,
            health: 43.0,
            remainingHealth: 43.0
        )
        
        let context = try! PokemonBattleContext(
            battlePokemons: [ pikachu, charmander ]
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
