//
//  Store.swift
//  Pods-VISPER_Redux_Example
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation

open class Store<ObservableProperty: ObservablePropertyType> : ActionDispatcher {
    
    public typealias StoreMiddleware = Middleware<ObservableProperty.ValueType>
    public typealias StoreReducer = AppReducer<ObservableProperty.ValueType>
    
    open private(set) var observable: ObservableProperty
    private let middleware: StoreMiddleware
    private let appReducer: StoreReducer
    private let reducerProvider: ReducerProvider
    private let disposeBag = SubscriptionReferenceBag()
    
    public init(appReducer: @escaping StoreReducer,
                 observable: ObservableProperty,
            reducerProvider: ReducerProvider,
                 middleware: StoreMiddleware = Middleware()) {
        
        self.appReducer = appReducer
        self.observable = observable
        self.middleware = middleware
        self.reducerProvider = reducerProvider
    }
    
    open func dispatch(_ actions: Action...) {
        actions.forEach { action in
            let dispatchFunction: (Action...) -> Void = { [weak self] (actions: Action...) in
                actions.forEach { self?.dispatch($0) }
            }
            middleware.transform({ self.observable.value }, dispatchFunction, action).forEach { action in
                observable.value = appReducer(self.reducerProvider,action, observable.value)
            }
        }
    }
    
    open func dispatch<S: StreamType>(_ stream: S) where S.ValueType: Action {
        disposeBag += stream.subscribe { [unowned self] action in
            self.dispatch(action)
        }
    }
}
