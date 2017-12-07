//
//  BattleMatchLandingViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 07/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMatchLandingViewController

import RealmSwift
import UIKit

public final class BattleMatchLandingViewController: UIViewController {
    
    // MARK: Property
    
    public final weak var matchDataProvider: BattleMatchDataProvider?
    
    // MARK: Action
    
    @IBAction public final func createBattle(_ sender: Any) {
        
        print(#function)
        
    }
    
    @IBAction public final func searchBattles() {
        
        guard
            let matchDataProvider = matchDataProvider
        else {
            
            // Todo: error handling
            
            return
            
        }
        
        let matchSearchViewController = BattleMatchSearchViewController()
        
        matchSearchViewController.matchDataProvider = matchDataProvider

        matchSearchViewController.controllerDelegate = self

        let navigationController = UINavigationController(rootViewController: matchSearchViewController)
        
        present(
            navigationController,
            animated: true,
            completion: nil
        )
        
    }
    
}

// MARK: - BattleMatchSearchViewControllerDelegate

import TinyBattleKit

extension BattleMatchLandingViewController: BattleMatchSearchViewControllerDelegate {
    
    public final func controller(
        _ controller: BattleMatchSearchViewController,
        didSelect match: BattleMatch
    ) {
        
    }
    
}
