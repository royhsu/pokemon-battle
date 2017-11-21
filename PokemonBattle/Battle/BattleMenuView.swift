//
//  BattleMenuView.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMenuView

import UIKit

public final class BattleMenuView: UIView {
    
    // MARK: Property
    
    public final let button = UIButton()
    
    // MARK: Init
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setUpButton(
            button,
            on: self
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setUpButton(
            button,
            on: self
        )
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpButton(
        _ button: UIButton,
        on view: UIView
    ) {
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        
        button
            .topAnchor
            .constraint(equalTo: view.topAnchor)
            .isActive = true
        
        button
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        
        button
            .bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
        
    }
    
}
