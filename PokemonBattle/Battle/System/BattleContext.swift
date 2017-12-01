//
//  BattleContext.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleContext

import TinyBattleKit

public struct BattleContext: BattleResult {
    
    // MARK: Property
    
    private var entityMap: [String: BattleEntity] = [:]
    
    // MARK: Init
    
    public init(entities: [BattleEntity]) throws {
        
        try entities.forEach { entity in
            
            guard
                entityMap[entity.id] == nil
            else { throw BattleContextError.duplicateEntityId }
            
            entityMap[entity.id] = entity
            
        }
        
    }
    
}

// MARK: - Entity

public extension BattleContext {
    
    public func entity(id: String) -> BattleEntity? { return entityMap[id] }
    
    public mutating func replaceEntity(with newValue: BattleEntity) { entityMap[newValue.id] = newValue }
    
}
