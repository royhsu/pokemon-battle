//
//  FirePokemonSkillProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - FirePokemonSkillProvider

import SpriteKit
import TinyBattleKit

public final class FirePokemonSkillProvider: PokemonSkillProvider {
    
    public typealias Animator = PokemonSkillAnimator
    
    public typealias Context = Animator.Context
    
    public typealias Result = Animator.Result
    
    // MARK: Property
    
    public final let id: String
    
    public final let priority: Double
    
    public final var animator: Animator? { return .fire(context: context) }
    
    // Extra damage ratio
    public final let extra = 0.25
    
    public final let sourceId: String
    
    public final let destinationIds: [String]
    
    public final let context: Context
    
    // MARK: Init
    
    public init(
        id: String,
        priority: Double,
        sourceId: String,
        destinationIds: [String],
        context: Context
    ) {
        
        self.id = id
        
        self.priority = priority
        
        self.sourceId = sourceId
        
        self.destinationIds = destinationIds
        
        self.context = context
        
    }
    
    // MARK: BattleActionProvider
    
    public final func applyAction(on result: PokemonBattleContext) -> PokemonBattleContext {
        
        var updatedResult = result
        
        let source = result
            .storage
            .values
            .flatMap { $0 }
            .filter { $0.id == sourceId }
            .first!

        destinationIds.forEach { destinationId in
        
            for (_, battlePokemons) in result.storage {
                
                guard
                    let index = battlePokemons.index(
                        where: { $0.id == destinationId }
                    )
                else { continue }
            
                let destination = battlePokemons[index]

                let finalMagic = source.magic * (1.0 + extra)

                let damage = finalMagic - destination.magicResistance

                var updatedDestination = destination

                updatedDestination.remainingHealth -= damage
                
                updatedResult.storage[destinationId]![0] = updatedDestination
                
            }
            
        }

        return updatedResult
        
    }
    
}
