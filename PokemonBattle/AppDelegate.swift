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
    
    public final var window: UIWindow?
    
    public final var realm: Realm?
    
    public final var realmServerDataProvider: RealmBattleServerDataProvider?
    
    public final var serverRealmMatchDataProvider: RealmBattleMatchDataProvider?
    
    public final var clientRealmMatchDataProvider: RealmBattleMatchDataProvider?
    
    public final var client: TurnBasedBattleServer?
    
    // MARK: UIApplicationDelegate

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {
        
//        let realm = try! Realm(
//            configuration: Realm.Configuration(inMemoryIdentifier: "battle-server")
//        )
//
//        self.realm = realm
//
//        let realmBattleMatchDataProvider = RealmBattleMatchDataProvider(realm: realm)
//
//        self.realmBattleMatchDataProvider = realmBattleMatchDataProvider
//
//        let realmServerDataProvider = RealmBattleServerDataProvider(realm: realm)
//
//        self.realmServerDataProvider = realmServerDataProvider
//
//        try! realm.write {
//
//            let player = BattlePlayerRealmObject(
//                value: [ "id": playerId ]
//            )
//
//            realm.add(player)
//
//            self.player = player
//
//            let now = Date()
//
//            let record = BattleRecordRealmObject(
//                value: [
//                    "id": UUID().uuidString,
//                    "createdAtDate": now.addingTimeInterval(-20.0),
//                    "updatedAtDate": now.addingTimeInterval(-20.0)
//                ]
//            )
//
//            record.owner = player
//
//            realm.add(record)
//
//            self.record = record
//
//        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = UIViewController()
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        setUpRealm(
            username: "realm-admin",
            password: ""
        )
        
        return true
        
    }
    
    fileprivate final func setUpRealm(
        username: String,
        password: String
    ) {
        
        let serverUrl = URL(string: "http://Roys-MacBook-Pro-15.local:9080")!
        
        let realmUrl = URL(string: "realm://Roys-MacBook-Pro-15.local:9080")!.appendingPathComponent("~/battle")
        
        SyncUser.logIn(
            with: .usernamePassword(
                username: username,
                password: password,
                register: false
            ),
            server: serverUrl,
            onCompletion: { user, error in
                
                if let error = error {
                    
                    print("\(error)")
                    
                    return
                    
                }
                
                guard
                    let user = user
                else { fatalError() }
                
                DispatchQueue.main.async {
                    
                    let configuration = Realm.Configuration(
                        syncConfiguration: SyncConfiguration(
                            user: user,
                            realmURL: realmUrl
                        )
                    )
                    
                    do {
                        
                        let realm = try Realm(configuration: configuration)
                        
                        self.realm = realm
                        
                        let realmServerDataProvider = RealmBattleServerDataProvider(realm: realm)
                        
                        self.realmServerDataProvider = realmServerDataProvider
                        
                        // Server
                        let owner = realm.object(
                            ofType: BattlePlayerRealmObject.self,
                            forPrimaryKey: "8FB6201A-133C-4174-B7AE-5EFE72E66C24"
                        )!
                        
                        let serverRealmMatchDataProvider = RealmBattleMatchDataProvider(
                            realm: realm,
                            serverDataProvider: realmServerDataProvider,
                            currentPlayer: PokemonBattlePlayer(owner)
                        )
                        
                        self.serverRealmMatchDataProvider = serverRealmMatchDataProvider
                        
                        let match = serverRealmMatchDataProvider.makeMatch()
                        
                        let server = serverRealmMatchDataProvider.makeServer(for: match)
                        
                        let serverMatchLobbyViewController = BattleMatchLobbyViewController(server: server)
                        
                        let serverNavigationController = UINavigationController(rootViewController: serverMatchLobbyViewController)
                        
                        // Client
                        let player = realm.object(
                            ofType: BattlePlayerRealmObject.self,
                            forPrimaryKey: "24E0AD21-DA77-403C-83B4-549333DFD76F"
                        )!
                        
                        let clientRealmMatchDataProvider = RealmBattleMatchDataProvider(
                            realm: realm,
                            serverDataProvider: realmServerDataProvider,
                            currentPlayer: PokemonBattlePlayer(player)
                        )
                        
                        self.clientRealmMatchDataProvider = clientRealmMatchDataProvider
                        
                        let clientMatchSearchViewController = BattleMatchSearchViewController()
                        
                        clientMatchSearchViewController.matchDataProvider = clientRealmMatchDataProvider
                        
                        let clientNavigationController = UINavigationController(rootViewController: clientMatchSearchViewController)
                        
                        self.window?.rootViewController = ParallelViewController(
                            leftViewController: serverNavigationController,
                            rightViewController: clientNavigationController
                        )
                        
                    }
                    catch { fatalError("\(error)") }
                    
                }
                
            }
        )
        
    }
    
//    fileprivate final func makeBattleViewController(with record: TurnBasedBattleRecord) -> UIViewController {
//
//        let pikachu = try! PokemonGenerator.make(Pikachu.self)
//
//        let charmander = try! PokemonGenerator.make(Charmander.self)
//
//        let context = PokemonBattleContext(
//            storage: [
//                pikachu.id: BattlePokemon(
//                    pikachu,
//                    role: .home
//                ),
//                charmander.id: BattlePokemon(
//                    charmander,
//                    role: .guest
//                )
//            ]
//        )
//
//        let server = TurnBasedBattleServer(
//            dataProvider: realmServerDataProvider!,
//            player: PokemonBattlePlayer(player!),
//            record: record
//        )
//
//        let pokemonBattleViewController = PokemonBattleViewController(
//            server: server,
//            homeBattlePokemonId: pikachu.id,
//            homeBattlePokemonImage: #imageLiteral(resourceName: "Pikachu"),
//            guestBattlePokemonId: charmander.id,
//            guestBattlePokemonImage: #imageLiteral(resourceName: "Charmander"),
//            context: context
//        )
//
//        return UINavigationController(rootViewController: pokemonBattleViewController)
//
//    }

}

extension AppDelegate: TurnBasedBattleServerDelegate {
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didUpdate record: TurnBasedBattleRecord
    ) {
        
    }
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
        server.respond(
            to: JoinedBattleRequest(
                joined: PokemonBattleJoined(
                    id: UUID().uuidString,
                    player: server.player
                )
            )
        )
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didStartTurn turn: TurnBasedBattleTurn
    ) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) {
        
    }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool {
        
        return false
        
    }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) {
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) {
        
    }
    
    public func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) { print("\(error)") }
    
}
