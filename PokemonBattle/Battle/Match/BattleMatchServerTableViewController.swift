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
    
    public final let server: TurnBasedBattleServer
    
    // MARK: Init
    
    public init(
        dataProvider: TurnBasedBattleServerDataProvider,
        owner: BattlePlayer,
        record: TurnBasedBattleRecord
    ) {
        
        let server = TurnBasedBattleServer(
            dataProvider: dataProvider,
            player: owner,
            record: record
        )
        
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
        
        navigationItem.title = "Server"
        
//        let rightBarButtonItem = UIBarButtonItem(
//            title: "Connect",
//            style: .plain,
//            target: self,
//            action: #selector(join)
//        )
//
//        rightBarButtonItem.isEnabled = false
//
//        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            BattleMatchClientTableViewCell.self,
            forCellReuseIdentifier: BattleMatchClientTableViewCell.identifier
        )
        
    }
    
    // MARK: Action
    
    @objc public final func join(_ sender: Any) {
    
//        guard
//            let serverDataProvider = serverDataProvider,
//            let player = serverDataProvider.fetchPlayer(id: "24E0AD21-DA77-403C-83B4-549333DFD76F"),
//            let record = serverDataProvider.fetchRecord(id: "31CFED91-78A4-4FB6-9A0A-A93F88F692A8")
//        else { return }
//
//        let client = TurnBasedBattleServer(
//            dataProvider: serverDataProvider,
//            player: player,
//            record: record
//        )
//
//        self.client = client
//
//        client.serverDelegate = self
//
//        client.resume()
//
    }
    
    // MARK: UITableViewDataSource
    
    public final override func numberOfSections(in tableView: UITableView) -> Int {
        
        return server.record.joinedPlayers.count
        
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
        
        let player = server.record.joinedPlayers[indexPath.section]
            
        cell.textLabel?.text = "Player: \(player.id)"
        
        return cell
            
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

extension BattleMatchServerTableViewController: TurnBasedBattleServerDelegate {
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didUpdate record: TurnBasedBattleRecord
    ) {
       
        tableView.reloadData()
        
    }
    
    public final func serverDidStart(_ server: TurnBasedBattleServer) {
        
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
    ) {
        
    }
    
}
