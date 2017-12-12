//
//  BattleMatchLobbyViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMatchLobbyViewController

import UIKit
import TinyBattleKit

public final class BattleMatchLobbyViewController: UITableViewController {

    // MARK: Property
    
    public final let server: TurnBasedBattleServer
    
    // MARK: Init
    
    public init(server: TurnBasedBattleServer) {
        
        self.server = server
        
        super.init(style: .plain)
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }

    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpNavigationItem(navigationItem)
        
        setUpTableView(tableView)
        
        server.serverDelegate = self
        
        server.resume()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpNavigationItem(_ navigationItem: UINavigationItem) {
        
        navigationItem.title = NSLocalizedString(
            "Lobby",
            comment: ""
        )
        
        let rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString(
                "Ready",
                comment: ""
            ),
            style: .plain,
            target: self,
            action: #selector(getReady)
        )

        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        if server.isOwner {
        
            let leftBatButtonItem = UIBarButtonItem(
                title: NSLocalizedString(
                    "Battle",
                    comment: ""
                ),
                style: .plain,
                target: self,
                action: #selector(startBattle)
            )
            
            leftBatButtonItem.isEnabled = !server.isOwner
            
            navigationItem.leftBarButtonItem = leftBatButtonItem
            
        }
        
    }
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            BattleMatchTableViewCell.self,
            forCellReuseIdentifier: BattleMatchTableViewCell.identifier
        )
        
    }
    
    // MARK: Action
    
    // Todo: add ability to cancel ready.
    @objc public final func getReady(_ sender: Any) {
    
        if server.isOwner {
            
            let pikachu = try! PokemonGenerator.make(Pikachu.self)
            
            server.respond(
                to: ReadyBattleRequest(
                    ready: PokemonBattleReady(
                        id: UUID().uuidString,
                        player: server.player,
                        entities: [
                            BattlePokemon(
                                id: UUID().uuidString,
                                pokemon: pikachu,
                                skills: [ PokemonSkill(name: "LIGHTNING") ]
                            )
                        ]
                    )
                )
            )
            
        }
        else {
            
            let charmander = try! PokemonGenerator.make(Charmander.self)
            
            server.respond(
                to: ReadyBattleRequest(
                    ready: PokemonBattleReady(
                        id: UUID().uuidString,
                        player: server.player,
                        entities: [
                            BattlePokemon(
                                id: UUID().uuidString,
                                pokemon: charmander,
                                skills: [ PokemonSkill(name: "FIRE") ]
                            )
                        ]
                    )
                )
            )
            
        }
        
    }
    
    @objc public final func startBattle(_ sender: Any) {
        
        if server.isOwner {
            
            server.respond(
                to: ContinueBattleRequest(owner: server.player)
            )
            
        }
        
    }
    
    // MARK: UITableViewDataSource
    
    public final override func numberOfSections(in tableView: UITableView) -> Int { return server.record.joineds.count }
    
    public final override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int { return 1 }
    
    public final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BattleMatchTableViewCell.identifier,
            for: indexPath
        ) as! BattleMatchTableViewCell
        
        let joined = server.record.joineds[indexPath.section]
        
        let player = joined.player
        
        cell.textLabel?.text = "Player: \(player.id)"
        
        let isPlayerReady = server.record.readys.contains { $0.player.id == player.id }
        
        cell.accessoryType =
            isPlayerReady
            ? .checkmark
            : .none
        
        return cell
            
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

extension BattleMatchLobbyViewController: TurnBasedBattleServerDelegate {
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didUpdate record: TurnBasedBattleRecord
    ) {
        
        tableView.reloadData()
        
        let isPlayerReady = server.record.readys.contains { $0.player.id == server.player.id }
        
        navigationItem.rightBarButtonItem?.isEnabled = !isPlayerReady
        
        if server.isOwner {
        
            // Todo: should use set instead of array for comparing joineds and readys in whole project.
            
            let joinedPlayerIds = Set(
                server.record.joineds.map { $0.player.id }
            )
            
            let readyPlayerIds = Set(
                server.record.readys.map { $0.player.id }
            )
            
            let isBattleReady =
                (joinedPlayerIds == readyPlayerIds)
                && !joinedPlayerIds.isEmpty
                && !readyPlayerIds.isEmpty

            navigationItem.leftBarButtonItem?.isEnabled = isBattleReady
            
        }
        
    }
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
        if server.isOwner {
            
            server.respond(
                to: JoinedBattleRequest(
                    joined: PokemonBattleJoined(
                        id: UUID().uuidString,
                        player: server.player
                    )
                )
            )
            
        }
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didStartTurn turn: TurnBasedBattleTurn
    ) {
        
        let battleViewController = PokemonBattleViewController(
            server: server,
            pokedex: Pokedex()
        )
        
        battleViewController.navigationItem.hidesBackButton = true
        
        navigationController?.pushViewController(
            battleViewController,
            animated: false
        )
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) { }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool { return false }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) { }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) { }
    
    public func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) {
       
        print(
            #function,
            "\(error)"
        )
        
    }
    
}
