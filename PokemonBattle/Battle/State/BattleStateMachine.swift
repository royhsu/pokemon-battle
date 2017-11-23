//
//  BattleStateMachine.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 20/11/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleStateMachineDelegate

public protocol BattleStateMachineDelegate: class {
    
    func stateMachine(
        _ stateMachine: BattleStateMachine,
        didTranstionFrom from: BattleState,
        to: BattleState
    )
    
    func stateMachine(
        _ stateMachine: BattleStateMachine,
        didFailWith error: Error
    )
    
}

// MARK: - BattleStateMachine

public final class BattleStateMachine {
    
    // MARK: Property
    
    private final var _state: BattleState {
        
        didSet {
            
            let newValue = _state
            
            stateMachineDelegate?.stateMachine(
                self,
                didTranstionFrom: oldValue,
                to: newValue
            )
            
        }
        
    }
    
    public final var state: BattleState {
        
        get { return _state }
        
        set {
            
            let oldValue = _state
            
            guard
                shouldTransition(
                    from: oldValue,
                    to: newValue
                )
            else {
                
                let error: BattleStateMachineError = .invalidTransition(
                    from: oldValue,
                    to: newValue
                )
                
                stateMachineDelegate?.stateMachine(
                    self,
                    didFailWith: error
                )
                
                return
                
            }
            
            _state = newValue
            
        }
        
    }
    
    public final weak var stateMachineDelegate: BattleStateMachineDelegate?
    
    // MARK: Init
    
    public init(initialState: BattleState) {
        
        self._state = initialState
        
    }
    
    // MARK: Transition
    
    internal final func shouldTransition(
        from: BattleState,
        to: BattleState
    ) -> Bool {
        
        switch (from, to) {
            
        case (.start, .preparing),
             (.preparing, .fighting),
             (.fighting, .result),
             (.result, .preparing),
             (.result, .end):
            
            return true
            
        default: return false
            
        }
        
    }
    
}
