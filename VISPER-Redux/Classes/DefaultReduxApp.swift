//
//  DefaultReduxApp.swift
//  VISPER-Redux
//
//  Created by bartel on 04.07.18.
//

import Foundation
import VISPER_Core
import VISPER_Reactive

open class DefaultReduxApp<AppState>: DefaultApp, ReduxApp {
    
    public typealias ApplicationObservableProperty = ObservableProperty<AppState>
    
    ///redux architecture of your project
    public let redux: Redux<AppState>
    
    /// observable app state property
    open var state: ObservableProperty<AppState> {
        return redux.store.observableState
    }
    
    
    internal var statefulFeatureObservers: [AnyStatefulFeatureObserver<AppState>] = [AnyStatefulFeatureObserver<AppState>]()
    
    public init(redux: Redux<AppState>){
        self.redux = redux
        super.init()
    }
    
    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    open override func add(feature: Feature) throws {
        
        try super.add(feature: feature)
        
        for observer in self.statefulFeatureObservers {
            let anyReduxApp = AnyReduxApp(self)
            try observer.featureAdded(application: anyReduxApp, feature: feature)
        }
        
    }
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    open func add<T : StatefulFeatureObserver>(featureObserver: T) where T.AppState == AppState{
        let anyObserver = AnyStatefulFeatureObserver<AppState>(featureObserver)
        self.statefulFeatureObservers.append(anyObserver)
    }
    
}
