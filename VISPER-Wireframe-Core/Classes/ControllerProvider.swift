//
//  ControllerProvider.swift
//  VISPER-Wireframe
//
//  Created by bartel on 18.11.17.
//

import Foundation


/// An instance providing a controller for an specific route pattern, routing option,
/// parameter combination if it is responsible for it
public protocol ControllerProvider {
    
    /// Checks if a ControllerProvider can create a controller for a RouteResult, RoutingOption combination
    ///
    /// - Parameters:
    ///   - routeResult: The route result for which a controller is searched
    ///   - routingOption: The routing option which describes how the created controller will be presented
    /// - Returns: true if it can create a controller, false otherwise
    func isResponsible( routeResult: RouteResult) -> Bool
    
    /// The provider return a view controller if he is responsible for
    ///
    /// - Parameters:
    ///   - routeResult: The route result for which a controller is searched
    ///   - routingOption: The routing option which describes how the created controller will be presented
    /// - Returns: a view controller
    func makeController( routeResult: RouteResult) throws -> UIViewController
    
}
