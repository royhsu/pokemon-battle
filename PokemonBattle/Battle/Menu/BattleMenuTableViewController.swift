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
    
    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpTableView(tableView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor(
            red: 0.80,
            green: 0.18,
            blue: 0.21,
            alpha: 1.00
        )
        
        tableView.register(
            UINib(
                nibName: "BattleMenuTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "BattleMenuTableViewCell"
        )
        
    }
    
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
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat {
        
        let verticalMargin: CGFloat = 10.0
        
        let numberOfPokemonSkills =
            menuDataProvider?.numberOfPokemonSkills()
            ?? 0
        
        if numberOfPokemonSkills == 0 { return 0.0 }
        
        let totalVerticalMargin =
            CGFloat(numberOfPokemonSkills + 1)
            * verticalMargin
        
        let height =
            (view.bounds.height - totalVerticalMargin)
            / CGFloat(numberOfPokemonSkills)
        
        return height
        
    }
    
    public final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BattleMenuTableViewCell",
            for: indexPath
        ) as! BattleMenuTableViewCell
        
        let skillTitle = menuDataProvider?.titleForPokemonSkill(at: indexPath.section)
        
        cell.skillLabel.text = skillTitle
        
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
        
    }
    
}
