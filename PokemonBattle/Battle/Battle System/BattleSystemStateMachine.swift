//
//  BattleSystemStateMachine.swift
//  PokemonBattle
//
//  Created by Roy Hsu on 01/12/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - BattleSystemStateMachineDelegate

public protocol BattleSystemStateMachineDelegate: class {
    
    func machine(
        _ machine: BattleSystemStateMachine,
        didTransitionFrom from: BattleSystemState,
        to: BattleSystemState
    )
    
    func machine(
        _ machine: BattleSystemStateMachine,
        didFailWith error: Error
    )
    
}

// MARK: - BattleSystemStateMachineError

public enum BattleSystemStateMachineError: Error {
    
    // MARK: Case
    
    case invalidTransition(
        from: BattleSystemState,
        to: BattleSystemState
    )
    
}

// MARK: - BattleSystemStateMachine

public final class BattleSystemStateMachine {
    
    // MARK: Property
    
    private final var _state: BattleSystemState {
        
        didSet {
            
            let newValue = _state
            
            machineDelegate?.machine(
                self,
                didTransitionFrom: oldValue,
                to: newValue
            )
            
        }
        
    }
    
    public final var state: BattleSystemState {
        
        get { return _state }
        
        set {
            
            let oldValue = _state
            
            guard
                shouldTransition(
                    from: oldValue,
                    to: newValue
                )
            else {
                
                let error: BattleSystemStateMachineError = .invalidTransition(
                    from: oldValue,
                    to: newValue
                )
                
                machineDelegate?.machine(
                    self,
                    didFailWith: error
                )
                
                return
                    
            }
            
            _state = newValue
            
        }
        
    }
    
    public final weak var machineDelegate: BattleSystemStateMachineDelegate?
    
    // MARK: Init
    
    public init(state: BattleSystemState) { self._state = state }
    
    // MARK: Transition
    
    public final func shouldTransition(
        from: BattleSystemState,
        to: BattleSystemState
    )
    -> Bool {
        
        switch (from, to) {
            
        case
        (.end, .start):
            
            return true
            
        default: return false
            
        }
            
    }
    
}
