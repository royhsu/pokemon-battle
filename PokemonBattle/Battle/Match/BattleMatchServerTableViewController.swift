//
//  BattleMatchServerTableViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMatchServerTableViewController

import UIKit
import TinyBattleKit

public final class BattleMatchServerTableViewController: UITableViewController {

    // MARK: Property
    
    public final let serverManager: PokemonBattleServerManager
    
    var client: TurnBasedBattleServer?
    
    public final weak var serverDataProvider: TurnBasedBattleServerDataProvider?
    
    public final var joinedPlayers: [BattlePlayer] = []
    
    // MARK: Init
    
    public init(
        serverManager: PokemonBattleServerManager
    ) {
        
        self.serverManager = serverManager
        
        super.init(style: .plain)
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implemented.") }

    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpNavigationItem(navigationItem)
        
        setUpTableView(tableView)
        
        serverManager.managerDelegate = self
        
        serverManager.resume()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpNavigationItem(_ navigationItem: UINavigationItem) {
        
        navigationItem.title = "Server"
        
        let rightBarButtonItem = UIBarButtonItem(
            title: "Connect",
            style: .plain,
            target: self,
            action: #selector(join)
        )
        
//        rightBarButtonItem.isEnabled = false
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            BattleMatchClientTableViewCell.self,
            forCellReuseIdentifier: BattleMatchClientTableViewCell.identifier
        )
        
    }
    
    // MARK: Action
    
    @objc public final func join(_ sender: Any) {
    
        guard
            let serverDataProvider = serverDataProvider,
            let player = serverDataProvider.fetchPlayer(id: "24E0AD21-DA77-403C-83B4-549333DFD76F"),
            let record = serverDataProvider.fetchRecord(id: "31CFED91-78A4-4FB6-9A0A-A93F88F692A8")
        else { return }
        
        let client = TurnBasedBattleServer(
            dataProvider: serverDataProvider,
            player: player,
            record: record
        )
        
        self.client = client
        
        client.serverDelegate = self
        
        client.resume()
        
    }
    
    // MARK: UITableViewDataSource
    
    public final override func numberOfSections(in tableView: UITableView) -> Int {
        
        return joinedPlayers.count
        
    }
    
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
            withIdentifier: BattleMatchClientTableViewCell.identifier,
            for: indexPath
        ) as! BattleMatchClientTableViewCell
        
        let player = joinedPlayers[indexPath.section]
            
        cell.textLabel?.text = "Player: \(player.id)"
        
        return cell
            
    }
    
}

extension BattleMatchServerTableViewController: TurnBasedBattleServerDelegate {
    
    public func server(
        _ server: TurnBasedBattleServer,
        didUpdate record: TurnBasedBattleRecord
    ) {
        
    }
    
    public func serverDidStart(_ server: TurnBasedBattleServer) {
        
        
        client?.respond(
            to: PlayerJoinBattleRequest(playerId: "24E0AD21-DA77-403C-83B4-549333DFD76F")
        )
        
    }
    
    public func server(_ server: TurnBasedBattleServer, didStartTurn turn: TurnBasedBattleTurn) {
        
    }
    
    public func server(_ server: TurnBasedBattleServer, didEndTurn turn: TurnBasedBattleTurn) {
        
    }
    
    public func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool {
        
        return false
        
    }
    
    public func serverDidEnd(_ server: TurnBasedBattleServer) {
        
    }
    
    public func server(_ server: TurnBasedBattleServer, didRespondTo request: BattleRequest) {
        
        if let request = request as? PlayerJoinBattleRequest {
            
            let player = server.serverDataProvider.fetchPlayer(id: request.playerId)!
            
            joinedPlayers.append(player)
            
            tableView.reloadData()
            
        }
        
        
    }
    
    public func server(_ server: TurnBasedBattleServer, didFailWith error: Error) {
        
    }
    
    
    
    
}

// MARK: - PokemonBattleServerManagerDelegate

extension BattleMatchServerTableViewController: PokemonBattleServerManagerDelegate {
    
    public final func manager(
        _ manager: PokemonBattleServerManager,
        didJoin player: BattlePlayer
    ) {
        
        joinedPlayers.append(player)
        
        tableView.reloadData()
        
    }
    
    public final func manager(
        _ manager: PokemonBattleServerManager,
        didFailWith error: Error
    ) { print("\(error)") }
    
}
