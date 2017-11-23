//
//  BattleMenuTableViewCell.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 23/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleMenuTableViewCell

import UIKit

public final class BattleMenuTableViewCell: UITableViewCell {
    
    // MARK: Property
    
    @IBOutlet fileprivate(set) final weak var skillLabel: UILabel!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpRootView(self)
        
        setUpSkillLabel(skillLabel)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: UIView) {
        
        view.backgroundColor = .clear
        
    }
    
    fileprivate final func setUpSkillLabel(_ label: UILabel) {
        
        label.backgroundColor = .white
        
        label.textColor = .black
        
        label.textAlignment = .center
        
        label.font = UIFont(
            name: "PokemonGB",
            size: 12.0
        )
        
        label.layer.shadowOpacity = 0.2
        
        label.layer.shadowColor = UIColor.black.cgColor
        
        label.layer.shadowRadius = 3.0
        
        label.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )
        
    }
    
}
