//
//  PokemonSkill.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkill

import TinyBattleKit

public protocol PokemonSkill {
    
    typealias Animator = PokemonSkillAnimator
    
    var name: String { get }
    
    func makeProvider(
        id: String,
        sourceId: String,
        destinationIds: [String],
        context: Animator.Context
    )
    -> AnyBattleActionProvider<Animator>
    
}
