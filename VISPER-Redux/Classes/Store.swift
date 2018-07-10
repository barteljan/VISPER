//
//  Store.swift
//  Pods-VISPER_Redux_Example
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation
import VISPER_Reactive
import VISPER_Core

open class Store<State> : ActionDispatcher {
    
    public typealias StoreMiddleware = Middleware<State>
    public typealias StoreReducer = AppReducer<State>
    
    open private(set) var observableState: ObservableProperty<State>
    private let middleware: StoreMiddleware
    private let appReducer: StoreReducer
    private var reducerContainer: StateChangingReducerContainer
    private let disposeBag = SubscriptionReferenceBag()
    private let dispatchQueue = DispatchQueue(label: "ActionDispatcher.Queue")
    
    public init(appReducer: @escaping StoreReducer,
               intialState: State,
           reducerContainer: StateChangingReducerContainer,
                middleware: StoreMiddleware = Middleware()) {
        
        self.appReducer = appReducer
        
        let observableProperty = ObservableProperty(intialState)
        self.observableState = observableProperty
        self.middleware = middleware
        self.reducerContainer = reducerContainer
        
        self.reducerContainer.dispatchStateChangeActionCallback = { [weak self] (action) in
            self?.dispatch(action)
        }
    }
    
    open func dispatch(_ actions: Action...) {
        actions.forEach { action in
            self.dispatch(action, completion: {})
        }
    }
    
    open func dispatch(_ action: Action, completion: @escaping () -> Void) {
        
        let dispatchFunction: (Action...) -> Void = { [weak self] (actions: Action...) in
            actions.forEach {
                self?.dispatch($0)
            }
        }
        
        middleware.transform({ self.observableState.value }, dispatchFunction, action).forEach { action in
            
            self.dispatchQueue.async(execute: {
                let value = self.appReducer(self.reducerContainer,action, self.observableState.value)
                
                DispatchQueue.main.sync {
                    self.observableState.value = value
                }
            })
            
        }
        
    }
    
    open func dispatch<S: StreamType>(_ stream: S) where S.ValueType: Action {
        disposeBag += stream.subscribe { [unowned self] action in
            self.dispatch(action)
        }
    }
}
