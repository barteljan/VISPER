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
    private let reducerProvider: ReducerProvider
    private let disposeBag = SubscriptionReferenceBag()
    
    public init(appReducer: @escaping StoreReducer,
               intialState: State,
           reducerProvider: ReducerProvider,
                middleware: StoreMiddleware = Middleware()) {
        
        self.appReducer = appReducer
        
        let observableProperty = ObservableProperty(intialState)
        self.observableState = observableProperty
        self.middleware = middleware
        self.reducerProvider = reducerProvider
    }
    
    open func dispatch(_ actions: Action...) {
        actions.forEach { action in
            let dispatchFunction: (Action...) -> Void = { [weak self] (actions: Action...) in
                actions.forEach { self?.dispatch($0) }
            }
            middleware.transform({ self.observableState.value }, dispatchFunction, action).forEach { action in
                observableState.value = appReducer(self.reducerProvider,action, observableState.value)
            }
        }
    }
    
    open func dispatch<S: StreamType>(_ stream: S) where S.ValueType: Action {
        disposeBag += stream.subscribe { [unowned self] action in
            self.dispatch(action)
        }
    }
}
