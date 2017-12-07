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
        
        guard
            let matchDataProvider = matchDataProvider
        else {
            
            // Todo: error handling
            
            return
                
        }
        
        matchDataProvider
            .connect(to: match)
            .then { server in
                
                print(#function, server)
//
//                controller.dismiss(
//                    animated: false,
//                    completion: nil
//                )
                
            }
            .catch { error in
                
                controller.navigationItem.rightBarButtonItem?.isEnabled = true
                
                controller.navigationItem.leftBarButtonItem?.isEnabled = true
                
                let alertController = UIAlertController(
                    title: nil,
                    message: error.localizedDescription,
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
                
                controller.present(
                    alertController,
                    animated: true,
                    completion: nil
                )
                
        }
        
    }
    
}
