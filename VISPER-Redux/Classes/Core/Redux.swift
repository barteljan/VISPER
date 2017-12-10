//
//  Redux.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation
import VISPER_Reactive


//open class Redux<AppState,DisposableType: SubscriptionReferenceType> {
open class Redux<ObservableProperty: ObservablePropertyType> {
    
    open let store : Store<ObservableProperty>
    
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
    
    public convenience init(initialState: ObservableProperty,
                middleware: Middleware<ObservableProperty.ValueType> = Middleware<ObservableProperty.ValueType>(),
                reducerContainer: ReducerContainer = ReducerContainerImpl()){
        
        let appReducer : AppReducer<ObservableProperty.ValueType> = {(provider, action, state) in
            return provider.reduce(action: action, state: state)
        }
        
        self.init(appReducer: appReducer,
                initialState: initialState,
                middleware: middleware,
                reducerContainer: reducerContainer)
    }
    
    public init(appReducer: @escaping AppReducer<ObservableProperty.ValueType>,
               initialState: ObservableProperty,
                 middleware: Middleware<ObservableProperty.ValueType> = Middleware<ObservableProperty.ValueType>(),
                 reducerContainer: ReducerContainer = ReducerContainerImpl()){
        
        self.reducerContainer = reducerContainer
        self.store = Store(appReducer: appReducer,
                            observable: initialState,
                       reducerProvider: reducerContainer,
                            middleware: middleware)
    }
    
}
