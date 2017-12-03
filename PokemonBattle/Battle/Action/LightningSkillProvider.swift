//
//  LightningSkillProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningSkillProvider

import TinyBattleKit
import SpriteKit

public final class LightningSkillProvider: BattleActionProvider {
    
    public typealias Animator = PokemonSkillAnimator
    
    public typealias Context = Animator.Context
    
    public typealias Result = Animator.Result
    
    // MARK: Property
    
    public final let priority = 100.0
    
    public final var animator: Animator? { return .lightning(context: context) }
    
    // Extra damage ratio
    public final let extra = 0.2
    
    // Todo: replace primetive type String with custom type PokemonID
    public final let sourceId: String
    
    // Todo: replace primetive type String with custom type PokemonID
    public final let destinationId: String
    
    public final let context: Context
    
    // MARK: Init
    
    public init(
        sourceId: String,
        destinationId: String,
        context: Context
    ) {
        
        self.sourceId = sourceId
        
        self.destinationId = destinationId
        
        self.context = context
        
    }
    
    // MARK: BattleActionProvider
    
    public final func applyAction(on result: BattleContext) -> BattleContext {
        
        let source = result.entity(id: sourceId)!
        
        let destination = result.entity(id: destinationId)!
        
        let finalMagic = source.magic * (1.0 + extra)
        
        let damage = finalMagic - destination.magicResistance
        
        var updatedDestination = destination
        
        updatedDestination.remainingHealth -= damage
        
        var updatedResult = result
        
        updatedResult.replaceEntity(with: updatedDestination)
    
        return updatedResult
        
    }
    
}

// MARK: Factory

public extension BattleActionProvider
where Self.Animator == PokemonSkillAnimator {
    
    public static func lightningSkill(
        sourceId: String,
        destinationId: String,
        context: Animator.Context
    )
    -> AnyBattleActionProvider<Animator> {
        
        let provider = LightningSkillProvider(
            sourceId: sourceId,
            destinationId: destinationId,
            context: context
        )
        
        return AnyBattleActionProvider(provider)
        
    }
    
}
