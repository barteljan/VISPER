//
//  PresenterFeatureObserver.swift
//  VISPER-Swift
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core

/// Add this FeatureObserver to your Application to configure your Redux for LogicFeatures providing reducers
public struct PresenterFeatureObserver: WireframeFeatureObserver {
    
    public init() {}
    
    public func featureAdded(application: WireframeApp,feature: Feature) throws {
        
        if let feature = feature as? PresenterFeature {
            application.wireframe.add(presenterProvider: feature, priority: feature.priority)
        }
    }
    
}
