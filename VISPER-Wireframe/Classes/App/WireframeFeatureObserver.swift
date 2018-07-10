//
//  WireframeFeatureObserver.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 04.07.18.
//

import Foundation
import VISPER_Core

public protocol WireframeFeatureObserver {
    func featureAdded(application: WireframeApp, feature: Feature) throws
}
