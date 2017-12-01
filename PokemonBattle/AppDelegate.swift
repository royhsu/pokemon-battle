//
//  AppDelegate.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit
import TinyBattleKit

@UIApplicationMain
public final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Property
    
    public final var window: UIWindow?
    
    // MARK: UIApplicationDelegate

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        setUpBattle(for: window)
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
        
    }
    
    // MARK: Set Up
    
    public final func setUpBattle(for window: UIWindow?) {
        
        let battleManager = BattleManager()
        
        battleManager.battlePokemonDataProvider = BasicBattlePokemonDataProvider(
            homeBattlePokemon: BattlePokemon(
                id: "home",
                pokemon: Pikachu()
            ),
            guestBattlePokemon: BattlePokemon(
                id: "guest",
                pokemon: Charmander()
            )
        )
        
        let battleViewController = BattleViewController(
            battleDelegate: battleManager
        )
        
        battleViewController.controllerDelegate = self
        
        window?.rootViewController = battleViewController
        
    }
    
}

// MARK: - BattleViewControllerDelegate

extension AppDelegate: BattleViewControllerDelegate {
    
    public final func battleViewController(
        _ battleViewController: BattleViewController,
        didEndWith result: LegacyBattleResult
    ) {
        
        let battleStoryboard = UIStoryboard(
            name: "Battle",
            bundle:
            nil
        )
        
        let battleViewController = battleStoryboard.instantiateViewController(withIdentifier: "BattleResultViewController") as! BattleResultViewController
        
        switch result {
            
        case .win:
            
            // Todo: add transition.
            
            battleViewController.title = "YOU WON!"
            
            battleViewController.controllerDelegate = self
            
            window?.rootViewController = battleViewController
            
        case .lose:
            
            // Todo: add transition.
            
            battleViewController.title = "YOU LOST!"
            
            battleViewController.controllerDelegate = self
            
            window?.rootViewController = battleViewController
            
        case .tbd: fatalError()
            
        }
        
    }
    
}

// MARK: - BattleResultViewControllerDelegate

extension AppDelegate: BattleResultViewControllerDelegate {
    
    public func battleResultViewControllerDidSelectAction(_ battleResultViewController: BattleResultViewController) {
        
        setUpBattle(for: window)
        
    }
    
}
