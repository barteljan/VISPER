//
//  RoutingHandlerContainer.swift
//  Pods
//
//  Created by bartel on 25.11.17.
//


import Foundation
import VISPER_Wireframe_Core

public protocol RoutingHandlerContainer {
    
    /// Register a handler for a route pattern
    /// The handler will be called if a route matches your route pattern.
    /// (you dont't have to add your pattern manually in this case)
    /// - Parameters:
    ///   - priority: The priority for calling your handler, higher priorities are called first. (Defaults to 0)
    ///   - responsibleFor: nil if this handler should be registered for every routing option, or a spec
    ///   - handler: A handler called when a route matches your route pattern
    func add( priority: Int,
        responsibleFor: @escaping (_ routeResult: RouteResult) -> Bool,
               handler: @escaping RoutingHandler) throws
    
    
    
    /// Returns the priority of the highest registered handler responsible for this RouteResult, RoutingOption combination
    ///
    /// - Parameters:
    ///   - routeResult: a RouteResult
    ///   - routingOption: a RoutingOption
    /// - Returns: priority of the highest registered handler
    func priorityOfHighestResponsibleProvider(routeResult: RouteResult) -> Int?
    
    
    
    /// Returns the registered handler with the highest priority responsible for this RouteResult, RoutingOption combination
    ///
    /// - Parameters:
    ///   - routeResult: a RouteResult
    ///   - routingOption: a RoutingOption
    /// - Returns: a routing handler if some is registered
    func handler(routeResult: RouteResult) -> RoutingHandler?
}


