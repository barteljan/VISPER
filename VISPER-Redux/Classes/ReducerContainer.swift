//
//  ReducerContainer.swift
//  VISPER-Redux
//
//  Created by Jan Bartel on 01.11.17.
//

import Foundation

/// An object which stores reducers and gives you all responsible reducers for a given action and state
public protocol ReducerContainer : ReducerProvider{
    
    /// Add a reducer to the contianer
    ///
    /// - Parameter reducer: a reducer
    func addReducer<R : ActionReducerType>(reducer: R)
    
    
    /// Add a reduce function to the container
    ///
    /// - Parameter reduceFunction: a reduce function
    func addReduceFunction<StateType, ActionType: Action>(reduceFunction:  @escaping (_ provider: ReducerProvider,_ action: ActionType, _ state: StateType) -> StateType)
    
}



open class ReducerContainerImpl : ReducerContainer {
    
    internal var reducers = [AnyActionReducer]()
    
    public init(){}
    
    /// Add a reducer to the contianer
    ///
    /// - Parameter reducer: a reducer
    open func addReducer<R : ActionReducerType>(reducer: R) {
        let anyReducer = AnyActionReducer(reducer)
        self.reducers.append(anyReducer)
    }
    
    
    /// Add a reduce function to the container
    ///
    /// - Parameter reduceFunction: a reduce function
    open func addReduceFunction<StateType, ActionType: Action>(reduceFunction:  @escaping (_ provider: ReducerProvider,_ action: ActionType, _ state: StateType) -> StateType){
        let funcReducer = FunctionReducer(reduceFunction: reduceFunction)
        self.addReducer(reducer: funcReducer)
    }
    
    
    /// Returns all responsible reducers for a given action, state pair
    ///
    /// - Parameters:
    ///   - action: an action
    ///   - state: the current state
    /// - Returns: all responsible reducers for this action state pair
    open func reducers<StateType>(action: Action,state: StateType) -> [AnyActionReducer]  {
        
        var responsibleReducers = [AnyActionReducer]()
        
        for reducer in reducers {
            if(reducer.isResponsible(action: action, state: state)){
                responsibleReducers.append(reducer)
            }
        }
        
        return responsibleReducers
    }
    
    
    /// reduce your state for an action, for all responsible reducers
    ///
    /// - Parameters:
    ///   - action: an action
    ///   - state: your current state
    /// - Returns: your new state
    open func reduce<StateType>(action: Action,state: StateType) -> StateType {
        
        var newState = state
        
        for reducer in self.reducers(action: action, state: state) {
            newState = reducer.reduce(provider: self, action: action, state: state)
        }
        
        return newState
    }
}
