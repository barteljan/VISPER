//
//  FeatureObserver.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 03.07.18.
//

import Foundation

public protocol FeatureObserver {
    func featureAdded(application: App, feature: Feature) throws
}
