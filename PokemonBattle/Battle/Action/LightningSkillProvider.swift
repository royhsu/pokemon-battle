//
//  LightningSkillProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - LightningSkillProvider

import TinyBattleKit

public final class LightningSkillProvider: BattleActionProvider {
    
    public typealias Result = BattleContext
    
    // MARK: Property
    
    public final let priority = 100.0
    
    // Extra damage ratio
    public final let extra = 0.2
    
    // Todo: replace primetive type String with custom type PokemonID
    public final let sourceId: String
    
    // Todo: replace primetive type String with custom type PokemonID
    public final let destinationId: String
    
    // MARK: Init
    
    public init(
        sourceId: String,
        destinationId: String
    ) {
        
        self.sourceId = sourceId
        
        self.destinationId = destinationId
        
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
where Self.Result == BattleContext {
    
    public static func lightningSkill(
        sourceId: String,
        destinationId: String
    )
    -> AnyBattleActionProvider<Result> {
        
        let provider = LightningSkillProvider(
            sourceId: sourceId,
            destinationId: destinationId
        )
        
        return AnyBattleActionProvider(provider)
        
    }
    
}

