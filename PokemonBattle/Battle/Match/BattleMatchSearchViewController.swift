//
//  BattleMatchClientTableViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMatchSearchViewControllerDelegate

public protocol BattleMatchSearchViewControllerDelegate: class {
    
    func controller(
        _ controller: BattleMatchSearchViewController,
        didSelect match: BattleMatch
    )
    
}

// MARK: - BattleMatchSearchViewController

import UIKit
import TinyBattleKit

public final class BattleMatchSearchViewController: UITableViewController {
    
    // MARK: Property
    
    public final weak var matchDataProvider: BattleMatchDataProvider?
    
    private final var selectedMatch: BattleMatch? {
        
        didSet {
            
            let isConnecting = (connectingServer != nil)
            
            navigationItem.rightBarButtonItem?.isEnabled = !isConnecting
            
        }
        
    }
    
    private final var connectingServer: TurnBasedBattleServer? {
        
        didSet {
            
            let isConnecting = (connectingServer != nil)
            
            navigationItem.rightBarButtonItem?.isEnabled = !isConnecting
                
            navigationItem.leftBarButtonItem?.isEnabled = !isConnecting
            
            tableView.isUserInteractionEnabled = !isConnecting
            
            if !isConnecting {
                
                // Todo: finish loading
                
            }
            
        }
        
    }
    
    public final weak var controllerDelegate: BattleMatchSearchViewControllerDelegate?
    
    // MARK: Init
    
    public init() { super.init(style: .plain) }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("Not implmented.") }
    
    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpNavigationItem(navigationItem)
        
        setUpTableView(tableView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpNavigationItem(_ navigationItem: UINavigationItem) {
        
        navigationItem.title = NSLocalizedString(
            "Search",
            comment: ""
        )
        
        let rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString(
                "Connect",
                comment: ""
            ),
            style: .plain,
            target: self,
            action: #selector(connectToMatch)
        )
        
        rightBarButtonItem.isEnabled = false
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
//        let leftBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .cancel,
//            target: self,
//            action: #selector(cancel)
//        )
//
//        navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            BattleMatchTableViewCell.self,
            forCellReuseIdentifier: BattleMatchTableViewCell.identifier
        )
        
    }
    
    // MARK: Action
    
    @objc final func connectToMatch(_ sender: Any) {
        
        guard
            let match = selectedMatch,
            let server = matchDataProvider?.makeServer(for: match)
        else { return }
        
        // Todo: add loading indicator

        connectingServer = server
        
        server.serverDelegate = self
        
        server.resume()
        
    }
    
    @objc final func cancel(_ sender: Any) {
        
        dismiss(
            animated: true,
            completion: nil
        )
        
    }
    
    // MARK: UITableViewDataSource
    
    public final override func numberOfSections(in tableView: UITableView) -> Int {
        
        return matchDataProvider?.numberOfMatches() ?? 0
        
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
            withIdentifier: BattleMatchTableViewCell.identifier,
            for: indexPath
        ) as! BattleMatchTableViewCell
        
        if let match = matchDataProvider?.match(at: indexPath.section) {
            
            cell.textLabel?.text = "Match: \(match.id)"
            
        }
        
        return cell
        
    }
    
    // MARK: UITableViewDelegate
    
    public final override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        selectedMatch = matchDataProvider?.match(at: indexPath.section)
        
    }
    
}

// MARK: - TurnBasedBattleServerDelegate

extension BattleMatchSearchViewController: TurnBasedBattleServerDelegate {
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didUpdate record: TurnBasedBattleRecord
    ) { }
    
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
        
        // Todo: exception handling
        
        connectingServer = nil
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didEndTurn turn: TurnBasedBattleTurn
    ) {
        
        // Todo: exception handling
        
        connectingServer = nil
        
    }
    
    public final func serverShouldEnd(_ server: TurnBasedBattleServer) -> Bool {
        
        return false
        
    }
    
    public final func serverDidEnd(_ server: TurnBasedBattleServer) {
        
        // Todo: exception handling
        
        connectingServer = nil
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didRespondTo request: BattleRequest
    ) {
        
        guard
            let currentPlayer = matchDataProvider?.currentPlayer,
            request is JoinedBattleRequest
        else { return }
        
        let hasCurrentPlayerJoined = server.record.joineds.contains { $0.player.id == currentPlayer.id }
        
        if hasCurrentPlayerJoined {
            
            let matchLobbyViewController = BattleMatchLobbyViewController(server: server)
            
            matchLobbyViewController.navigationItem.hidesBackButton = true
            
            navigationController?.pushViewController(
                matchLobbyViewController,
                animated: false
            )
            
        }
        
    }
    
    public final func server(
        _ server: TurnBasedBattleServer,
        didFailWith error: Error
    ) {
        
        connectingServer = nil
        
        let alertController = UIAlertController(
            title: nil,
            message: "\(error)",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: NSLocalizedString(
                "OK",
                comment: ""
            ),
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(okAction)
        
        present(
            alertController,
            animated: true,
            completion: nil
        )
        
    }
    
}
