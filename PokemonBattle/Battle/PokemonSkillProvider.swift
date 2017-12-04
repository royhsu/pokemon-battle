//
//  PokemonSkillProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkillProvider

import TinyBattleKit

public protocol PokemonSkillProvider: BattleActionProvider {
    
    associatedtype Animator = PokemonSkillAnimator
    
    typealias Context = Animator.Context
    
    var sourceId: String { get }
    
    var destinationIds: [String] { get }
    
    var context: Context { get }
    
    init(
        id: String,
        sourceId: String,
        destinationIds: [String],
        context: Context
    )
    
}
