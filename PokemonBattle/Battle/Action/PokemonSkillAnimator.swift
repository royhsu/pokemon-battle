//
//  PokemonSkillAnimator.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 03/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - PokemonSkillAnimator

import TinyBattleKit

public struct PokemonSkillAnimator: BattleActionAnimator {
    
    public typealias Context = PokemonSkillAnimatorContext
    
    public typealias Result = BattleContext
    
    public typealias Animation = (
        _ old: BattleContext,
        _ new: BattleContext,
        _ completion: () -> Void
    )
    -> Void
    
    // MARK: Property
    
    public let context: Context
    
    public let animation: Animation
    
    // MARK: Init
    
    public init(
        context: Context,
        animation: @escaping Animation
    ) {
        
        self.context = context
        
        self.animation = animation
        
    }
    
    // MARK: BattleActionAnimator
    
    public func animate(
        from oldResult: BattleContext,
        to newResult: BattleContext,
        completion: () -> Void
    ) {
        
        animation(
            oldResult,
            newResult,
            completion
        )
        
    }
    
}
