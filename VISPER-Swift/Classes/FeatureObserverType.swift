//
//  File.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Reactive

/// A observer observing all added features and configuring your application
public protocol FeatureObserverType {
    
    associatedtype ApplicationState
    associatedtype DisposableType: SubscriptionReferenceType
    
    func featureAdded(application: Application<ApplicationState,DisposableType>, feature: Feature) throws
}
