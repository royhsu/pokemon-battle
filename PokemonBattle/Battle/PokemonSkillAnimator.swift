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
    
    public typealias Result = PokemonBattleContext
    
    public typealias Animation = (
        _ old: Result,
        _ new: Result,
        _ completion: @escaping () -> Void
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
        from oldResult: Result,
        to newResult: Result,
        completion: @escaping () -> Void
    ) {
        
        animation(
            oldResult,
            newResult,
            completion
        )
        
    }
    
}
