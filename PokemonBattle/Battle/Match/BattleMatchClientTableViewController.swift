//
//  BattleMatchClientTableViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 05/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMatchClientTableViewController

import UIKit

public final class BattleMatchClientTableViewController: UITableViewController {
    
    // MARK: Property
    
    public final weak var matchDataProvider: BattleMatchDataProvider?
    
    private final var selectedMatch: BattleMatch? {
        
        didSet {
            
            navigationItem.rightBarButtonItem?.isEnabled = (selectedMatch != nil)
            
        }
        
    }
    
    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpNavigationItem(navigationItem)
        
        setUpTableView(tableView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpNavigationItem(_ navigationItem: UINavigationItem) {
        
        let rightBarButtonItem = UIBarButtonItem(
            title: "Connect",
            style: .plain,
            target: self,
            action: #selector(connectToServer)
        )
        
        rightBarButtonItem.isEnabled = false
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            BattleMatchClientTableViewCell.self,
            forCellReuseIdentifier: BattleMatchClientTableViewCell.identifier
        )
        
    }
    
    // MARK: Action
    
    @objc final func connectToServer(_ sender: Any) {
        
        navigationItem.rightBarButtonItem?.isEnabled = false
 
        print("connect")
        
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
            withIdentifier: BattleMatchClientTableViewCell.identifier,
            for: indexPath
        ) as! BattleMatchClientTableViewCell
        
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
        
        if let match = matchDataProvider?.match(at: indexPath.section) {
            
            selectedMatch = match
            
        }
        
    }
    
}
