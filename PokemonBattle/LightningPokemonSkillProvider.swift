//
//  LightningPokemonSkillProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningPokemonSkillProvider

import SpriteKit
import TinyBattleKit

public final class LightningPokemonSkillProvider: BattleActionProvider {
    
    public typealias Animator = PokemonSkillAnimator
    
    public typealias Context = Animator.Context
    
    public typealias Result = Animator.Result
    
    // MARK: Property
    
    public final let id: String
    
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
        id: String,
        sourceId: String,
        destinationId: String,
        context: Context
    ) {
        
        self.id = id
        
        self.sourceId = sourceId
        
        self.destinationId = destinationId
        
        self.context = context
        
    }
    
    // MARK: BattleActionProvider
    
    public final func applyAction(on result: PokemonBattleContext) -> PokemonBattleContext {
        
        let source = result.battlePokemon(id: sourceId)!

        let destination = result.battlePokemon(id: destinationId)!

        let finalMagic = source.magic * (1.0 + extra)

        let damage = finalMagic - destination.magicResistance

        var updatedDestination = destination

        updatedDestination.remainingHealth -= damage

        var updatedResult = result

        updatedResult.replaceBattlePokemon(with: updatedDestination)

        return updatedResult
        
    }
    
}

// MARK: Factory

public extension BattleActionProvider
where Self.Animator == PokemonSkillAnimator {
    
    public static func lightningSkill(
        id: String,
        sourceId: String,
        destinationId: String,
        context: Animator.Context
    )
    -> AnyBattleActionProvider<Animator> {
        
        let provider = LightningPokemonSkillProvider(
            id: id,
            sourceId: sourceId,
            destinationId: destinationId,
            context: context
        )
        
        return AnyBattleActionProvider(provider)
        
    }
    
}
