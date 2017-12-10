//
//  LogicFeatureObserver.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Reactive

/// Add this FeatureObserver to your Application to configure your Redux for LogicFeatures providing reducers
public struct LogicFeatureObserver<AppState,DisposableT: SubscriptionReferenceType>: FeatureObserverType {
    
    public typealias ApplicationState = AppState
    public typealias DisposableType = DisposableT

    public init() {}
    
    public func featureAdded(application: Application<AppState,DisposableType>,feature: Feature) throws {
        
        if let feature = feature as? LogicFeature {
            feature.injectReducers(container: application.redux.reducerContainer)
        }
    }
    
}
