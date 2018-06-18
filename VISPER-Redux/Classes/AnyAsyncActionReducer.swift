//
//  AnyAsyncActionReducer.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 15.06.18.
//

import Foundation
import VISPER_Core

/// A substitution wrapper for an instance of ActionReducerType
public struct AnyAsyncActionReducer {
    
    private let _isResponsible : (_ action: Action, _ state: Any) -> Bool
    private let _reduce: (_ provider: ReducerProvider,_ action: Action, _ completion: @escaping (Any) -> Void) -> Void
    
    /// Create an AnyActionReducer with an instance of type ActionReducerType
    public init<R : AsyncActionReducerType>(_ reducer : R){
        let actionReducer = AsyncActionReducer(reducer)
        self.init(actionReducer)
    }
    
    /// Create an AnyActionReducer with an instance of an ActionReducer
    public init<StateType, ActionType>(_ reducer : AsyncActionReducer<StateType,ActionType>) {
        
        self._isResponsible = reducer.isResponsible(action:state:)
        
        self._reduce = { container, action, completion in
            guard let action = action as? ActionType else {
                return
            }
            reducer.reduce(provider: container,action: action, completion: completion)
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
    public func reduce<StateType>(provider: ReducerProvider,
                       action: Action,
                       completion: @escaping (_ newState: StateType) -> Void) {
        
        let wrappedCompletion = { (newState: Any) -> Void in
            guard let newState = newState as? StateType else {
                return
            }
            completion(newState)
        }
        
        self._reduce(provider,action,wrappedCompletion)
    }
    
}
