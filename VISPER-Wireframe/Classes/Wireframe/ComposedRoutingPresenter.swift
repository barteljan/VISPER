//
//  ComposedRoutingPresenter.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 21.11.17.
//

import Foundation
import VISPER_Wireframe_Core

public protocol ComposedRoutingPresenter : RoutingPresenter{
    
    /// Add an instance responsible for presenting view controllers.
    /// It will be triggert after the wireframe resolves a route
    ///
    /// - Parameters:
    ///    - routingPresenter: An instance responsible for presenting view controllers
    ///    - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    func add(routingPresenter: RoutingPresenter,priority: Int)
    
}
