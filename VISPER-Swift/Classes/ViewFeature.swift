//
//  ViewFeature.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//
import Foundation
import VISPER_Core

/// A feature providing a view controller and routing options for a specific route pattern
///  - Note: Routing options specify how your controller will be presented
public protocol ViewFeature: Feature, RoutingOptionProvider, ControllerProvider {
    
    /// The route pattern of your feature
    var routePattern: String {get}
    
    /// features with high priority will be handeled earlier than features with a low priority
    /// eg. high priority features might block low priority features
    var priority : Int {get}
    
    /// Create a default routing option for your route pattern
    ///
    /// - Parameters:
    ///   - routePattern: a route pattern
    ///   - parameters: the routing option for your controller
    /// - Returns: A default routing option if you can provide one for this input parameter combination, nil otherwise
    func makeOption(routeResult: RouteResult) -> RoutingOption
    
    
}

public extension ViewFeature {
    
    public func option(routeResult: RouteResult) -> RoutingOption? {
        
        guard routeResult.routingOption == nil else {
            return routeResult.routingOption
        }
        
        if self.routePattern == routePattern {
            return self.makeOption(routeResult: routeResult)
        }
        
        return nil
    }
    
    
    func isResponsible(routeResult: RouteResult) -> Bool {
        return routeResult.routePattern == self.routePattern
    }
    

}
