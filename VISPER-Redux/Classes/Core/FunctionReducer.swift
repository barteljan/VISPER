//
//  FunctionReducer.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation


/// An FunctionReducer, uses a function to take a given action and a given state and return a new state
public struct FunctionReducer<StateType,ActionType : Action> : ActionReducerType{
    
    public typealias ReducerActionType = ActionType
    public typealias ReducerStateType = StateType
    
    let reduceFunction : (_ provider: ReducerProvider, _ action: ActionType, _ state: StateType) -> StateType
    
    /// Initialise the ActionReducer with a function, converting the current AppState to a new AppState
    /// You can provide a reduceFunction for ad hoc use, or overwrite ActionReducer if you want to create a more complex reducer
    public init(reduceFunction : @escaping (_ provider: ReducerProvider,
                                            _    action: ActionType,
                                            _     state: StateType) -> StateType){
        self.reduceFunction = reduceFunction
    }
    
    
    /// Take a given action, modify a given state and return a new state
    ///
    /// - Parameters:
    ///   - provider: the reducer container of your application
    ///   - action: a given action
    ///   - state: a given state
    /// - Returns: the new state
    public func reduce(provider: ReducerProvider, action: ActionType, state: StateType) -> StateType {
        return reduceFunction(provider,action,state)
    }
    
    
}
