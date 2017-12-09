//
//  ViewFeatureObserver.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//
import Foundation


/// Add this FeatureObserver to your Application to configure your wireframe for ViewFeatures
public struct ViewFeatureObserver<AppState>: FeatureObserverType {
    
    public typealias ApplicationState = AppState
    
    public init() {}
    
    public func featureAdded(application: Application<AppState>,feature: Feature) throws {
        
        if let feature = feature as? ViewFeature {
            application.wireframe.add(controllerProvider: feature, priority: feature.priority)
            application.wireframe.add(optionProvider: feature, priority: feature.priority)
            try application.wireframe.add(routePattern: feature.routePattern)
        }
        
    }
    
}
