//
//  LogicFeatureObserver.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Core

/// Add this FeatureObserver to your Application to configure your Redux for LogicFeatures providing reducers
public struct LogicFeatureObserver<ApplicationState>: StatefulFeatureObserver {
    
    public typealias AppState = ApplicationState

    public init() {}
    
    public func featureAdded(application: AnyReduxApp<ApplicationState>,feature: Feature) throws {
        
        if let feature = feature as? LogicFeature {
            feature.injectReducers(container: application.redux.reducerContainer)
        }
    }
    
}
