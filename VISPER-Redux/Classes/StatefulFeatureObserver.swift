//
//  File.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Core

/// A observer observing all added features and configuring your application
public protocol StatefulFeatureObserver {
    associatedtype AppState
    func featureAdded(application: AnyReduxApp<AppState>, feature: Feature) throws
}
