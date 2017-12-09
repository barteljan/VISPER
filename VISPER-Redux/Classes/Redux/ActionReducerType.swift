//
//  Reducer.swift
//  Pods-VISPER_Redux_Example
//
//  Created by Jan Bartel on 26.10.17.
//

import Foundation

/// An ActionReducer, takes a given action and a given state and returns a new state
public protocol ActionReducerType {
    
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
                    state: ReducerStateType) -> ReducerStateType
}



/// A default implementation for isResponsible (simply check if the given action and state conform to the reducers action and state types)
public extension ActionReducerType {
    
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









