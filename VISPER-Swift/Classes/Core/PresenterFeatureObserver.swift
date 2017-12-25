//
//  PresenterFeatureObserver.swift
//  VISPER-Swift
//
//  Created by bartel on 15.12.17.
//

import Foundation

import Foundation
import VISPER_Redux
import VISPER_Core

/// Add this FeatureObserver to your Application to configure your Redux for LogicFeatures providing reducers
public struct PresenterFeatureObserver<ObservableStateProperty: ObservablePropertyType>: FeatureObserverType {
    
    public typealias ObservableProperty = ObservableStateProperty
    
    public init() {}
    
    public func featureAdded(application: Application<ObservableProperty>,feature: Feature) throws {
        
        if let feature = feature as? PresenterFeature {
            application.wireframe.add(presenterProvider: feature, priority: feature.priority)
        }
    }
    
}
