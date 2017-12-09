//
//  Redux.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation


open class Redux<AppState> {
    
    open let store : Store<ObservableProperty<AppState>>
    
    open let reducerContainer : ReducerContainer
    
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
    
    public convenience init(initialState: AppState,
                middleware: Middleware<AppState> = Middleware<AppState>(),
                reducerContainer: ReducerContainer = ReducerContainerImpl()){
        
        let appReducer : AppReducer<AppState> = {(provider, action, state) in
            return provider.reduce(action: action, state: state)
        }
        
        self.init(appReducer: appReducer,
                initialState: initialState,
                middleware: middleware,
                reducerContainer: reducerContainer)
    }
    
    public init(appReducer: @escaping AppReducer<AppState>,
               initialState: AppState,
                 middleware: Middleware<AppState> = Middleware<AppState>(),
                 reducerContainer: ReducerContainer = ReducerContainerImpl()){
        
        self.reducerContainer = reducerContainer
        self.store = Store(appReducer: appReducer,
                            observable: ObservableProperty(initialState),
                       reducerProvider: reducerContainer,
                            middleware: middleware)
    }
    
}
