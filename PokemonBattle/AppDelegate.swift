//
//  AppDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import RealmSwift
import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Property
    
    public final var window: UIWindow?
    
    public final var realm: Realm?
    
    public final var realmBattleMatchDataProvider: RealmBattleMatchDataProvider?
    
    // MARK: UIApplicationDelegate

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let realm = try! Realm(
            configuration: Realm.Configuration(inMemoryIdentifier: "battle-server")
        )
        
        self.realm = realm
        
        let playerId = UUID().uuidString
        
        try! realm.write {
            
            let player = BattlePlayerRealmObject(
                value: [ "id": playerId ]
            )
            
            realm.add(player)
            
            let record = BattleRecordRealmObject(
                value: [ "id": UUID().uuidString ]
            )
            
            record.owner = player
            
            realm.add(record)
            
        }
        
        let realmBattleMatchDataProvider = RealmBattleMatchDataProvider(realm: realm)
        
        self.realmBattleMatchDataProvider = realmBattleMatchDataProvider
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = makeBattleMatchViewController()
        
//        window.rootViewController = makeBattleViewController()
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
        
    }
    
    fileprivate final func makeBattleMatchViewController() -> UIViewController {
        
        let battleMatchClientTableViewController = BattleMatchClientTableViewController(style: .plain)
        
        battleMatchClientTableViewController.matchDataProvider = realmBattleMatchDataProvider
        
        return UINavigationController(rootViewController: battleMatchClientTableViewController)
        
    }
    
    fileprivate final func makeBattleViewController() -> UIViewController {
        
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
        
        return UINavigationController(rootViewController: pokemonBattleViewController)
        
    }

}
