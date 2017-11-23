//
//  BattleMenuTableViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMenuTableViewController

import UIKit

public final class BattleMenuTableViewController: UITableViewController {
    
    // MARK: Property
    
    public final weak var menuDataProvider: BattleMenuDataProvider?
    
    // MARK: UITableViewDataSource
    
    public final override func numberOfSections(in tableView: UITableView) -> Int {
        
        return menuDataProvider?.numberOfPokemonSkills() ?? 0
        
    }
    
    public final override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { return 1 }
    
    public final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = menuDataProvider?.titleForPokemonSkill(at: indexPath.section)
        
        return cell
        
    }
    
}
