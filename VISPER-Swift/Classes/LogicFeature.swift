//
//  LogicFeature.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux

/// A feature providing reducers for your Redux
public protocol LogicFeature: Feature{
    func injectReducers(container: ReducerContainer)
}
