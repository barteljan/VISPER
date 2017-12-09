//
//  LogicFeatureObserver.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux

/// Add this FeatureObserver to your Application to configure your Redux for LogicFeatures providing reducers
public struct LogicFeatureObserver<AppState>: FeatureObserverType {
    
    public typealias ApplicationState = AppState

    public init() {}
    
    public func featureAdded(application: Application<AppState>,feature: Feature) throws {
        
        if let feature = feature as? LogicFeature {
            feature.injectReducers(container: application.redux.reducerContainer)
        }
    }
    
}
