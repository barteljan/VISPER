//
//  ComposedRoutingObserver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 22.11.17.
//

import Foundation
import VISPER_Wireframe_Core

public protocol ComposedRoutingObserver : RoutingObserver{
    
    /// Add an instance observing controllers before they are presented
    ///
    /// - Parameters:
    ///   - routingObserver: An instance observing controllers before they are presented
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    ///   - routePattern: The route pattern to call this observer, the observer is called for every route if this pattern is nil
    func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?)
    
}
