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
    
    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpTableView(tableView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            BattleMatchClientTableViewCell.self,
            forCellReuseIdentifier: BattleMatchClientTableViewCell.identifier
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
            withIdentifier: BattleMatchClientTableViewCell.identifier,
            for: indexPath
        ) as! BattleMatchClientTableViewCell
        
        cell.textLabel?.text = "Match: \(indexPath.section)"
        
        return cell
        
    }
    
}
