//
//  Application.swift
//  SwiftyVISPER
//
//  Created by bartel on 15.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Wireframe_Core

/// A SwiftyVisper application, containing all dependencies which should be configured by features
open class Application<AppState> : ApplicationType {
    
    public typealias ApplicationState = AppState
    
    public init(wireframe: Wireframe, redux: Redux<AppState>){
        self.wireframe = wireframe
        self.redux = redux
    }
    
    /// observable app state property
    open var state: ObservableProperty<AppState> {
        return redux.store.observable
    }
    
    /// the wireframe responsible for routing between your view controllers
    public let wireframe: Wireframe
    
    //redux architecture of your project
    public let redux: Redux<AppState>
    
    internal var featureObserver: [AnyFeatureObserver<AppState>] = [AnyFeatureObserver<AppState>]()
    
    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    open func add(feature: Feature) throws {
        
        for observer in self.featureObserver {
            try observer.featureAdded(application: self, feature: feature)
        }
        
    }
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    open func add<T : FeatureObserverType>(featureObserver: T) where T.ApplicationState == AppState {
        let anyObserver = AnyFeatureObserver<AppState>(featureObserver)
        self.featureObserver.append(anyObserver)
    }
    
}




