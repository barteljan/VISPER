//
//  DefaultApp.swift
//  VISPER-Core
//
//  Created by bartel on 03.07.18.
//

import Foundation

open class DefaultApp: App {
    
    internal var featureObservers: [FeatureObserver] = [FeatureObserver]()
    
    public init(){}
    
    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    open func add(feature: Feature) throws {
        for observer in self.featureObservers {
            try observer.featureAdded(application: self, feature: feature)
        }
    }
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    open func add(featureObserver: FeatureObserver) {
        self.featureObservers.append(featureObserver)
    }
    
}
