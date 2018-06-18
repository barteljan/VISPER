//
//  AsyncReducerType.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 15.06.18.
//

import Foundation

import Foundation
import VISPER_Core

/// An ActionReducer, takes a given action and a given state and returns a new state
public protocol AsyncActionReducerType {
    
    associatedtype ReducerStateType
    associatedtype ReducerActionType : Action
    
    /// Check if this reducer is responsible for a given action and state
    ///
    /// - Parameters:
    ///   - action: a given action
    ///   - state: a given state
    /// - Returns: returns if the reducer is responsible for this action/state pair
    func isResponsible(action: Action, state: Any) -> Bool
    
    /// Take a given action, modify a given state and return a new state
    ///
    /// - Parameters:
    ///   - provider: the reducer container of your application
    ///   - action: a given action
    ///   - state: a given state
    /// - Returns: the new state
    func reduce(provider: ReducerProvider,
                action: ReducerActionType,
                completion: @escaping (_ newState: ReducerStateType) -> Void)
}



/// A default implementation for isResponsible (simply check if the given action and state conform to the reducers action and state types)
public extension AsyncActionReducerType {
    
    /// Check if this reducer is responsible for a given action and state
    /// - Note: The default implementation simply checks if the given action and state conform to the reducers action and state types
    /// - Parameters:
    ///   - action: a given action
    ///   - state: a given state
    /// - Returns: returns if the reducer is responsible for this action/state pair
    public func isResponsible(action: Action, state: Any) -> Bool {
        return action is ReducerActionType && state is ReducerStateType
    }
    
}
