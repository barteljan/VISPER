//
//  ReducerContainer.swift
//  VISPER-Redux
//
//  Created by Jan Bartel on 01.11.17.
//

import Foundation
import VISPER_Core

/// An object which stores reducers and gives you all responsible reducers for a given action and state
public protocol ReducerContainer : class, ReducerProvider {
    
    /// Add a synchron reducer to the container
    ///
    /// - Parameter reducer: a reducer
    func addReducer<R : ActionReducerType>(reducer: R)
    
    
    /// Add a asynchron reducer to the container
    ///
    /// - Parameter reducer: a reducer
    func addReducer<R : AsyncActionReducerType>(reducer: R)
    
    /// Add a reduce function to the container
    ///
    /// - Parameter reduceFunction: a reduce function
    func addReduceFunction<StateType, ActionType: Action>(    @escaping (_ provider: ReducerProvider,_ action: ActionType, _ state: StateType) -> StateType)
    
}


public protocol StateChangingReducerContainer: ReducerContainer{
    var dispatchStateChangeActionCallback: ((Action) -> Void)? {get set}
}


open class ReducerContainerImpl : StateChangingReducerContainer {
   
    internal var wrappers = [ReducerWrapper]()
    
    open var dispatchStateChangeActionCallback: ((Action) -> Void)?
    
    public init(){}
    
    /// Add a sychron reducer to the container
    ///
    /// - Parameter reducer: a reducer
    open func addReducer<R : ActionReducerType>(reducer: R) {
        let anyReducer = AnyActionReducer(reducer)
        let reducerWrapper = ReducerWrapper(syncronizedReducer: anyReducer, asyncReducer: nil)
        self.wrappers.append(reducerWrapper)
    }
    
    /// Add a asynchron reducer to the container
    ///
    /// - Parameter reducer: a reducer
    open func addReducer<R : AsyncActionReducerType>(reducer: R) {
        let anyAsyncReducer = AnyAsyncActionReducer(reducer)
        let reducerWrapper = ReducerWrapper(syncronizedReducer: nil, asyncReducer: anyAsyncReducer)
        self.wrappers.append(reducerWrapper)
    }
    
    
    
    /// Add a reduce function to the container
    ///
    /// - Parameter reduceFunction: a reduce function
    open func addReduceFunction<StateType, ActionType: Action>(reduceFunction:  @escaping (_ provider: ReducerProvider,_ action: ActionType, _ state: StateType) -> StateType){
        let funcReducer = FunctionalReducer(reduceFunction: reduceFunction)
        self.addReducer(reducer: funcReducer)
    }
    
    
    /// Returns all responsible synchron reducers for a given action, state pair
    ///
    /// - Parameters:
    ///   - action: an action
    ///   - state: the current state
    /// - Returns: all responsible reducers for this action state pair
    open func reducers<StateType>(action: Action,state: StateType) -> [AnyActionReducer]  {
        
        var responsibleReducers = [AnyActionReducer]()
        
        for wrapper in self.wrappers {
            if let reducer = wrapper.syncronizedReducer {
                if(reducer.isResponsible(action: action, state: state)){
                    responsibleReducers.append(reducer)
                }
            }
        }
        
        return responsibleReducers
    }
    
    /// Returns all responsible async reducers for a given action, state pair
    ///
    /// - Parameters:
    ///   - action: an action
    ///   - state: the current state
    /// - Returns: all responsible reducers for this action state pair
    open func reducers<StateType>(action: Action,state: StateType) -> [AnyAsyncActionReducer]  {
        
        var responsibleReducers = [AnyAsyncActionReducer]()
        
        for wrapper in self.wrappers {
            if let reducer = wrapper.asyncReducer {
                if(reducer.isResponsible(action: action, state: state)){
                    responsibleReducers.append(reducer)
                }
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
        return self.reduce(action: action, state: state, completion: {})
    }
    
    
    /// reduce your state for an action, for all responsible reducers
    ///
    /// - Parameters:
    ///   - action: an action
    ///   - state: your current state
    ///   - completion: copletion called when the action was reduced
    /// - Returns: your new state
    open func reduce<StateType>(action: Action, state: StateType, completion: @escaping () -> Void) -> StateType {
        
        var newState = state
        var didCallAllReducers = false
        
        var numberOfResponsibleAsyncReducers = 0
        var numberOfCompletionsCalled = 0
        var completionCalled = false
        
        for wrapper in self.wrappers {
            //update state if it is a synchronous reducer
            if let reducer = wrapper.syncronizedReducer {
                if reducer.isResponsible(action: action, state: state) {
                    newState = reducer.reduce(provider: self, action: action, state: state)
                }
            }
            // if it is an async reducer, then call it's async reduce function,
            // the actions completion will be called after all async reducers have called their completion
            else if let reducer = wrapper.asyncReducer {
                
                
                if reducer.isResponsible(action: action, state: state) {
                
                    guard let dipatchAsyncCallback = self.dispatchStateChangeActionCallback else {
                        fatalError("dispatchStateChangeActionCallback should be set before a async reducer is called, since it could not call a state changing completion otherwise.")
                    }
                    
                    numberOfResponsibleAsyncReducers += 1
                    
                    //assure that the actions completion ist called after all async reducers had completeded
                    let wrappedCompletion = { (newState: StateType) -> Void in
                        numberOfCompletionsCalled += 1
                        
                        let action = UpdateStateWithSubStateAction(subState: newState)
                        dipatchAsyncCallback(action)
                        
                        if didCallAllReducers && !completionCalled && numberOfResponsibleAsyncReducers == numberOfCompletionsCalled {
                            completion()
                            completionCalled = true
                        } else if completionCalled {
                            fatalError("completion should not be called multiple times")
                        }
                    }
                    
                    reducer.reduce(provider: self, action: action, completion: wrappedCompletion)
                }
            }
        }
        
        didCallAllReducers = true
        
        //assure that the actions completion ist called after all async reducers had completeded
        if !completionCalled && numberOfResponsibleAsyncReducers == numberOfCompletionsCalled {
            completion()
            completionCalled = true
        } else if completionCalled {
            fatalError("completion should not be called multiple times")
        }
        
        return newState
    }
    
    struct ReducerWrapper {
        var syncronizedReducer: AnyActionReducer?
        var asyncReducer: AnyAsyncActionReducer?
    }
    
}
