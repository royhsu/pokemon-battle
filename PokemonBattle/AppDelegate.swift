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
    
    public final let lightningSkillId = UUID().uuidString
    
    public final let fireSkillId = UUID().uuidString
    
    public final let pokedex = Pokedex()
    
    // MARK: UIApplicationDelegate

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = UIViewController()
        
        window.makeKeyAndVisible()
        
        self.window = window

//        pokedex.registerSkillType(
//            LightningPokemonSkill.self,
//            withIdentifier: lightningSkillId
//        )
//
//        pokedex.registerSkillType(
//            FirePokemonSkill.self,
//            withIdentifier: fireSkillId
//        )
        
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
                    
                    let config = Realm.Configuration(
                        syncConfiguration: SyncConfiguration(
                            user: user,
                            realmURL: realmUrl
                        )
                    )
                    
                    do {
                        
                        let realm = try Realm(configuration: config)
                        
                        self.realm = realm
                        
                        let realmServerDataProvider = RealmBattleServerDataProvider(realm: realm)
                        
                        self.realmServerDataProvider = realmServerDataProvider
                        
                        // Todo: test only
                        
//                        let playerA = BattlePlayerRealmObject(
//                            value: [ "id": "8FB6201A-133C-4174-B7AE-5EFE72E66C24" ]
//                        )
//
//                        let playerB = BattlePlayerRealmObject(
//                            value: [ "id": "24E0AD21-DA77-403C-83B4-549333DFD76F" ]
//                        )
//
//                        let record = BattleRecordRealmObject(
//                            value: [ "id": "31CFED91-78A4-4FB6-9A0A-A93F88F692A8" ]
//                        )
//
//                        record.owner = playerA
//
//                        try! realm.write {
//
//                            realm.add(playerA)
//
//                            realm.add(playerB)
//
//                            realm.add(record)
//
//                        }
//
//                        return
                        
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
                        
                        self.window?.rootViewController = DualViewController(
                            topViewController: clientNavigationController,
                            bottomViewController: serverNavigationController
                        )
                        
                    }
                    catch { fatalError("\(error)") }
                    
                }
                
            }
        )
        
    }

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
