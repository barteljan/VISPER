//
//  AsyncActionReducer.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 15.06.18.
//

import Foundation
import VISPER_Core

/// An struct wrapping a implementation of ActionReducerType
public struct AsyncActionReducer<StateType,ActionType: Action>: AsyncActionReducerType {
    
    public typealias ReducerActionType = ActionType
    public typealias ReducerStateType = StateType
    
    private let _isResponsible : (_ action: Action, _ state: Any) -> Bool
    
    private let _reduce: (_ provider: ReducerProvider, _ action: ActionType, _ completion: @escaping (_ newState: StateType) -> Void ) -> Void
    
    public init<A : AsyncActionReducerType>(_ reducer: A) where A.ReducerStateType == StateType, A.ReducerActionType == ActionType {
        self._isResponsible = reducer.isResponsible(action:state:)
        self._reduce = reducer.reduce(provider:action:completion:)
        //self._reduce = reducer.reduce(provider:action:state:completion)
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
    public func reduce(provider: ReducerProvider,
                       action: ReducerActionType,
                       completion: @escaping (_ newState: ReducerStateType) -> Void) {
        return self._reduce(provider,action, completion)
    }
}
