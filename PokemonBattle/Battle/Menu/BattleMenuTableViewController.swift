//
//  BattleMenuTableViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMenuTableViewControllerDelegate

public protocol BattleMenuTableViewControllerDelegate: class {
    
    func tableViewController(
        _ tableViewController: BattleMenuTableViewController,
        didSelectSkillAt index: Int
    )
    
}

// MARK: - BattleMenuTableViewController

import UIKit

public final class BattleMenuTableViewController: UITableViewController {
    
    // MARK: Property
    
    public final weak var menuDataProvider: BattleMenuDataProvider?
    
    public final weak var menuControllerDelegate: BattleMenuTableViewControllerDelegate?
    
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
    
    // MARK: UITableViewDelegate
    
    public final override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        menuControllerDelegate?.tableViewController(
            self,
            didSelectSkillAt: indexPath.section
        )
        
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.isSelected = false
        
    }
    
}
