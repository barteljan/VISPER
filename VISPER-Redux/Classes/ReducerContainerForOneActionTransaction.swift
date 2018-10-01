//
//  OneActionTransactionReducerContainer.swift
//  VISPER-Redux
//
//  Created by bartel on 27.09.18.
//

import Foundation
import VISPER_Core

public class ReducerContainerForOneActionTransaction: StateChangingReducerContainer {
    
    public var dispatchStateChangeActionCallback: ((Action) -> Void)?
    
    let reducerContainer: StateChangingReducerContainer
    let combineLatest: CombineLatestClosures
    
    public init(reducerContainer: StateChangingReducerContainer, completion: @escaping () -> Void) {
        self.reducerContainer = reducerContainer
        self.combineLatest = CombineLatestClosures(allCallbacksAreCalled: completion)
    }
    
    public func addReducer<R>(reducer: R) where R : ActionReducerType {
        self.reducerContainer.addReducer(reducer: reducer)
    }
    
    public func addReducer<R>(reducer: R) where R : AsyncActionReducerType {
        self.reducerContainer.addReducer(reducer: reducer)
    }
    
    public func addReduceFunction<StateType, ActionType>(reduceFunction: @escaping (ReducerProvider, ActionType, StateType) -> StateType) where ActionType : Action {
        self.reducerContainer.addReduceFunction(reduceFunction: reduceFunction)
    }
    
    public func reducers<StateType>(action: Action, state: StateType) -> [AnyActionReducer] {
        return self.reducerContainer.reducers(action: action, state: state)
    }
    
    public func reducers<StateType>(action: Action, state: StateType) -> [AnyAsyncActionReducer] {
        return self.reducerContainer.reducers(action: action, state: state)
    }
    
    public func reduce<StateType>(action: Action, state: StateType) -> StateType {
        return self.reduce(action: action, state: state, completion: {})
    }
    
    public func reduce<StateType>(action: Action, state: StateType, completion: @escaping () -> Void) -> StateType {
        let observedCompletion = self.combineLatest.chainClosure(callback: completion)
        let state = self.reducerContainer.reduce(action: action, state: state, completion: observedCompletion)
        return state
    }
    
    public func startCompleting() {
        self.combineLatest.combineLatest()
    }
}
