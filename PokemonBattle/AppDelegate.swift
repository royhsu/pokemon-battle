//
//  AppDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import RealmSwift
import TinyBattleKit
import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Property
    
    public final let playerId = UUID().uuidString
    
    public final var window: UIWindow?
    
    public final var realm: Realm?
    
    public final var realmServerDataProvider: RealmServerDataProvider?
    
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
        
        let realmServerDataProvider = RealmServerDataProvider(realm: realm)
        
        self.realmServerDataProvider = realmServerDataProvider
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = makeBattleMatchViewController()
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
        
    }
    
    fileprivate final func makeBattleMatchViewController() -> UIViewController {
        
        let battleMatchClientTableViewController = BattleMatchClientTableViewController(style: .plain)
        
        battleMatchClientTableViewController.matchDataProvider = realmBattleMatchDataProvider
        
        battleMatchClientTableViewController.controllerDelegate = self
        
        return UINavigationController(rootViewController: battleMatchClientTableViewController)
        
    }
    
    fileprivate final func makeBattleViewController(with match: BattleMatch) -> UIViewController {
        
        let pikachu = try! PokemonGenerator.make(Pikachu.self)
        
        let charmander = try! PokemonGenerator.make(Charmander.self)
        
        let context = try! PokemonBattleContext(
            battlePokemons: [
                BattlePokemon(pikachu),
                BattlePokemon(charmander)
            ]
        )
        
        let server = TurnBasedBattleServer(
            ownerId: playerId,
            recordId: match.id
        )
        
        server.serverDataProvider = realmServerDataProvider
        
        let pokemonBattleViewController = PokemonBattleViewController(
            server: server,
            homeBattlePokemonId: pikachu.id,
            homeBattlePokemonImage: #imageLiteral(resourceName: "Pikachu"),
            guestBattlePokemonId: charmander.id,
            guestBattlePokemonImage: #imageLiteral(resourceName: "Charmander"),
            context: context
        )
        
        return UINavigationController(rootViewController: pokemonBattleViewController)
        
    }

}

// MARK: - BattleMatchClientTableViewControllerDelegate

extension AppDelegate: BattleMatchClientTableViewControllerDelegate {
    
    public func controller(
        _ controller: BattleMatchClientTableViewController,
        connectTo match: BattleMatch
    ) { window?.rootViewController = makeBattleViewController(with: match) }
    
}
