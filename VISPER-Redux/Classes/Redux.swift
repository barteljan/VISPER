//
//  Redux.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation
import VISPER_Core

open class Redux<State> {
    
    public let store : Store<State>
    
    open var reducerContainer : ReducerContainer

    open var reducerProvider : ReducerProvider {
        get {
            return self.reducerContainer
        }
    }
    
    open var actionDispatcher : ActionDispatcher {
        get {
            return self.store
        }
    }
    
    public convenience init(initialState: State,
                middleware: Middleware<State> = Middleware<State>(),
                reducerContainer: StateChangingReducerContainer = ReducerContainerImpl()){
        
    
        
        let appReducer : AppReducer<State> = {(provider, action, state) in
            return provider.reduce(action: action, state: state)
        }
        
        self.init(appReducer: appReducer,
                initialState: initialState,
                middleware: middleware,
                reducerContainer: reducerContainer)
    }
    
    public init(appReducer: @escaping AppReducer<State>,
               initialState: State,
                 middleware: Middleware<State> = Middleware<State>(),
                 reducerContainer: StateChangingReducerContainer = ReducerContainerImpl()){
        
        self.reducerContainer = reducerContainer
        self.store = Store(appReducer: appReducer,
                          intialState: initialState,
                     reducerContainer: reducerContainer,
                           middleware: middleware)
    }
    
}
