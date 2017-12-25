//
//  File.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Core

/// A observer observing all added features and configuring your application
public protocol FeatureObserverType {
    associatedtype ObservableProperty: ObservablePropertyType
    func featureAdded(application: Application<ObservableProperty>, feature: Feature) throws
}
