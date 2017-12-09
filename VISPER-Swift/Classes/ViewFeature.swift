//
//  ViewFeature.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//
import Foundation
import VISPER_Wireframe_Core

/// A feature providing a view controller and routing options for a specific route pattern
///  - Note: Routing options specify how your controller will be presented
public protocol ViewFeature: Feature, RoutingOptionProvider, ControllerProvider {
    
    /// The route pattern of your feature
    var routePattern: String {get}
    
    /// features with high priority will be handeled earlier than features with a low priority
    /// eg. high priority features might block low priority features
    var priority : Int {get}
    
    /// Create a controller for your route pattern
    ///
    /// - Parameters:
    ///   - routingOption: the routing option for your controller
    ///   - parameters: all parameters given to your controller
    /// - Returns: A UIViewController if you can create a controller for this input parameter combination, nil otherwise
    func makeController(routingOption: RoutingOption,
                           parameters: [String : Any]) -> UIViewController?
    
    /// Create a default routing option for your route pattern
    ///
    /// - Parameters:
    ///   - routePattern: a route pattern
    ///   - parameters: the routing option for your controller
    /// - Returns: A default routing option if you can provide one for this input parameter combination, nil otherwise
    func makeOption(routePattern: String,
                      parameters: [String : Any]) -> RoutingOption?
    
    
}

public extension ViewFeature {
    
    public var priority : Int {
        return 0
    }
    
    public func controller(routePattern: String,
                          routingOption: RoutingOption,
                             parameters: [String : Any]) -> UIViewController? {
       
        if self.routePattern == routePattern {
            return self.makeController(routingOption: routingOption,
                                          parameters: parameters)
        }
        
        return nil
    }
    
    
    public func option(routePattern: String,
                         parameters: [String : Any],
                      currentOption: RoutingOption?) -> RoutingOption? {
        
        guard currentOption == nil else {
            return currentOption
        }
        
        if self.routePattern == routePattern {
            return self.makeOption(routePattern: routePattern,
                                     parameters: parameters)
        }
        
        return nil
    }
}
