//
//  BattleMenuTableViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMenuTableViewControllerDelegate

public protocol BattleMenuTableViewControllerDelegate: class {
    
    func controller(
        _ controller: BattleMenuTableViewController,
        didSelectSkillAt index: Int
    )
    
}

// MARK: - BattleMenuTableViewController

import UIKit

public final class BattleMenuTableViewController: UITableViewController {
    
    // MARK: Property
    
    public final weak var controllerDataSource: BattleMenuTableViewControllerDataSource?
    
    public final weak var controllerDelegate: BattleMenuTableViewControllerDelegate?
    
    // MARK: Init
    
    public init() { super.init(style: .plain) }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
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
        
        return controllerDataSource?.numberOfPokemonSkills() ?? 0
        
    }
    
    public final override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { return 1 }
    
    public final override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat { return 150.0 }
    
    public final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BattleMenuTableViewCell",
            for: indexPath
        ) as! BattleMenuTableViewCell
        
        let skillTitle = controllerDataSource?.titleForPokemonSkill(at: indexPath.section)
        
        cell.skillLabel.text = skillTitle
        
        return cell
        
    }
    
    // MARK: UITableViewDelegate
    
    public final override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        controllerDelegate?.controller(
            self,
            didSelectSkillAt: indexPath.section
        )
        
    }
    
}
