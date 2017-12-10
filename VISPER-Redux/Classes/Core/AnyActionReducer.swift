//
//  AnyActionReducer.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation

/// A substitution wrapper for an instance of ActionReducerType
public struct AnyActionReducer {
    
    private let _isResponsible : (_ action: Action, _ state: Any) -> Bool
    private let _reduce: (_ provider: ReducerProvider,_ action: Action, _ state: Any) -> Any
    
    /// Create an AnyActionReducer with an instance of type ActionReducerType
    public init<R : ActionReducerType>(_ reducer : R){
        let actionReducer = ActionReducer(reducer)
        self.init(actionReducer)
    }
    
    /// Create an AnyActionReducer with an instance of an ActionReducer
    public init<StateType, ActionType>(_ reducer : ActionReducer<StateType,ActionType>) {
        
        self._isResponsible = reducer.isResponsible(action:state:)
        
        self._reduce = { container,action,state in
            
            if let action = action as? ActionType,let state = state as? StateType {
                return reducer.reduce(provider: container,action: action, state: state)
            }
            
            return state
        }
        
    }
    
    /// Check if this reducer is responsible for a given action and state
    /// - Note: The default implementation simply checks if the given action and state conform to the reducers action and state types
    /// - Parameters:
    ///   - action: a given action
    ///   - state: a given state
    /// - Returns: returns if the reducer is responsible for this action/state pair
    public func isResponsible(action: Action, state: Any) -> Bool {
        return self._isResponsible(action,state)
    }
    
    /// Take a given action, modify a given state and return a new state
    ///
    /// - Parameters:
    ///   - action: a given action
    ///   - state: a given state
    /// - Returns: the new state
    public func reduce<StateType>(provider: ReducerProvider,action: Action, state: StateType) -> StateType {
        
        if let newState = self._reduce(provider,action,state) as? StateType {
            return newState
        }
        
        return state
    }
    
}
