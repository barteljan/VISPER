//
//  RouteResult.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 19.11.17.
//

import Foundation
import VISPER_Wireframe_Core

public struct DefaultRouteResult : RouteResult, Equatable {
    
    public let routePattern: String
    public let parameters: [String : Any]
    public var routingOption: RoutingOption?
    
    public init(routePattern: String, parameters: [String : Any], routingOption: RoutingOption?){
        self.routePattern = routePattern
        self.parameters = parameters
        self.routingOption = routingOption
    }
    
    public init(routePattern: String,parameters: [String : Any]){
        self.init(routePattern: routePattern, parameters: parameters, routingOption: nil)
    }
    
    public static func ==(lhs: DefaultRouteResult, rhs: DefaultRouteResult) -> Bool {
        return lhs.isEqual(routeResult: rhs)
    }
    
}
