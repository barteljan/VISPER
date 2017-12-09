//
//  File.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation

/// A observer observing all added features and configuring your application
public protocol FeatureObserverType {
    
    associatedtype ApplicationState
    
    func featureAdded(application: Application<ApplicationState>, feature: Feature) throws
}
