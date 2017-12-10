//
//  AppReducer.swift
//  Pods-VISPER_Redux_Example
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation


/// An object which gives you all responsible reducers for a given action and state
public protocol ReducerProvider {
    
    
    /// Returns all responsible reducers for a given action, state pair
    ///
    /// - Parameters:
    ///   - action: an action
    ///   - state: the current state
    /// - Returns: all responsible reducers for this action state pair
    func reducers<StateType>(action: Action,state: StateType) -> [AnyActionReducer]
    
    
    
    /// reduce your state for an action, for all responsible reducers
    ///
    /// - Parameters:
    ///   - action: an action
    ///   - state: your current state
    /// - Returns: your new state
    func reduce<StateType>(action: Action,state: StateType) -> StateType
    
}



