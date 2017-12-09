//
//  ApplicationType.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Wireframe_Core

/// A SwiftyVisper application type, containing all dependencies which should be configured by features
public protocol ApplicationType {
    
    associatedtype ApplicationState
    
    /// observable app state property
    var state: ObservableProperty<ApplicationState> {get}
    
    /// the wireframe responsible for routing between your view controllers
    var wireframe : Wireframe {get}
    
    //redux architecture of your project
    var redux : Redux<ApplicationState> {get}
    
    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    func add(feature: Feature) throws
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    func add<T : FeatureObserverType>(featureObserver: T) where T.ApplicationState == ApplicationState
}
