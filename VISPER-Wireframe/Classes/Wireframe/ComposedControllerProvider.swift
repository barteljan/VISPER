//
//  File.swift
//  VISPER-Wireframe
//
//  Created by bartel on 22.11.17.
//

import Foundation
import VISPER_Wireframe_Core

public protocol ComposedControllerProvider : ControllerProvider {
    
    
    /// Returns the highest priority of a responsible child controller provider
    ///
    /// - Parameters:
    ///   - routeResult: a RouteResult
    ///   - routingOption: a RoutingOption
    /// - Returns: nil if none was found, highest priority if a responsible provider was found
    func priorityOfHighestResponsibleProvider(routeResult: RouteResult) -> Int?
    
    /// Add an instance providing a controller for a route
    ///
    /// - Parameters:
    ///   - controllerProvider: instance providing a controller
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    func add(controllerProvider: ControllerProvider, priority: Int)
    
}
