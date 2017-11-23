//
//  BattleResultViewController.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleResultViewController

import UIKit

public final class BattleResultViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet fileprivate final weak var titleLabel: UILabel!
    
    @IBOutlet fileprivate final weak var actionLabel: UILabel!
   
    @IBOutlet fileprivate final weak var actionButton: UIButton!
    
    // MARK: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpRootView(view)
        
        setUpTitleLabel(
            titleLabel,
            withTitle: title
        )
        
        setUpActionLabel(actionLabel)
        
        setUpActionButton(actionButton)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: UIView) {
        
        view.backgroundColor = UIColor(
            red: 0.80,
            green: 0.18,
            blue: 0.21,
            alpha: 1.00
        )
        
    }
    
    fileprivate final func setUpTitleLabel(
        _ label: UILabel,
        withTitle title: String?
        
    ) {
        
        label.text = title
        
        label.textColor = .white
        
        label.font = UIFont.systemFont(
            ofSize: 50.0,
            weight: .heavy
        )
        
        label.layer.shadowOpacity = 0.2
        
        label.layer.shadowColor = UIColor.black.cgColor
        
        label.layer.shadowRadius = 3.0
        
        label.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )
        
    }
    
    fileprivate final func setUpActionLabel(_ label: UILabel) {
        
        label.backgroundColor = .white
        
        label.textColor = .black
        
        label.font = UIFont(
            name: "PokemonGB",
            size: 12.0
        )
        
        label.text = "Play Again"
        
        label.layer.shadowOpacity = 0.2
        
        label.layer.shadowColor = UIColor.black.cgColor
        
        label.layer.shadowRadius = 3.0
        
        label.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )
        
    }
    
    fileprivate final func setUpActionButton(_ button: UIButton) {
        
        button.setTitle(
            nil,
            for: .normal
        )
        
        button.addTarget(
            self,
            action: #selector(playAgain),
            for: .touchUpInside
        )
        
    }
    
    // MARK: Action
    
    @objc public final func playAgain(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
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

        appDelegate.window?.rootViewController = battleViewController
        
    }
    
}
