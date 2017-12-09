//
//  ActionDispatcher.swift
//  Pods-VISPER_Redux_Example
//
//  Created by Jan Bartel on 26.10.17.
//

import Foundation


/**
   An ActionDispatcher is an object which takes an action to modify a given state
      - SeeAlso: `Action`, for the object which will be dispatched
 **/
public protocol ActionDispatcher {
    
    ///
    /// Apply a given action to a given state to return the changed state modified by all reducers
    /// who are responsible for this state
    ///
    /// - Parameters:
    ///   - state: The current state to be modified
    ///   - action: The actions to modify the current state
    /// - Returns: A new modified state
    /// - SeeAlso: `Action`, for the object which will be dispatched
    func dispatch(_ action: Action ...)
    
}
