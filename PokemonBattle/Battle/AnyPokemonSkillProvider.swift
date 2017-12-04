//
//  AnyPokemonSkillProvider.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 04/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - AnyPokemonSkillProvider

import TinyBattleKit

public class AnyPokemonSkillProvider: PokemonSkillProvider {
    
    public typealias Context = PokemonSkillAnimatorContext
    
    // MARK: Property
    
    private final let _id: String
    
    private final let _priority: Double
    
    private final let _animator: Animator?
    
    private final let _applyAction: (Result) -> Result
    
    private final let _sourceId: String
    
    private final let _destinationIds: [String]
    
    private final let _context: Animator.Context
    
    // MARK: Init
    
    public init<Provider: PokemonSkillProvider>(_ provider: Provider) {
        
        self._id = provider.id
        
        self._priority = provider.priority
        
        self._animator = provider.animator
        
        self._applyAction = provider.applyAction
        
        self._sourceId = provider.sourceId
        
        self._destinationIds = provider.destinationIds
        
        self._context = provider.context
        
    }
    
    // MARK: BattleActionProvider
    
    public final var id: String { return _id }
    
    public final var priority: Double { return _priority }
    
    public final var animator: PokemonSkillAnimator? { return _animator }
    
    public final func applyAction(on result: PokemonBattleContext) -> PokemonBattleContext { return _applyAction(result) }
    
    // MARK: PokemonSkillProvider
    
    public var sourceId: String { return _sourceId }
    
    public var destinationIds: [String] { return _destinationIds }
    
    public var context: Context { return _context }
    
}
