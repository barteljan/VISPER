//
//  ReduxAppFactory.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 20.07.18.
//

import Foundation

open class ReduxAppFactory<AppState> {

    open var strictReduxMode: Bool = false
    
    public init(){}
    
    /// create a default application
    open func makeApplication( redux: Redux<AppState>) -> AnyReduxApp<AppState> {
        
        let application = DefaultReduxApp(redux: redux)
        let anyApplication = AnyReduxApp(application)
        self.configure(application: anyApplication)
        return anyApplication
        
    }
    
    /// create a default application
    open func makeApplication(initialState: AppState,
                              appReducer: @escaping AppReducer<AppState>) -> AnyReduxApp<AppState>{
        let redux = Redux( appReducer: appReducer,
                           initialState: initialState)
        return self.makeApplication(redux: redux)
    }
    
    /// configure an application
    open func configure(application: AnyReduxApp<AppState>) {
        self.addDefaultFeatureObserver(application: application)
    }
    
    open func addDefaultFeatureObserver(application: AnyReduxApp<AppState>){
        
        let logicFeatureObserver = LogicFeatureObserver<AppState>()
        application.add(featureObserver: logicFeatureObserver)
        
        let stateObservingFeatureObserver = StateObservingFeatureObserver<AppState,AppState>(state: application.state)
        application.add(featureObserver: stateObservingFeatureObserver)
        
    }
    
    
}
