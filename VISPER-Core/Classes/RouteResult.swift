//
//  RouteResult.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 19.11.17.
//

import Foundation

public protocol RouteResult {
    var routePattern: String {get}
    var routingOption: RoutingOption? {get set}
    var parameters: [String : Any] {get}
    
    func isEqual(routeResult: RouteResult?) -> Bool
}

public extension RouteResult {
    
    public func isEqual(routeResult: RouteResult?) -> Bool {
        
        guard let routeResult = routeResult else {
            return false
        }
        
        let lhsParams = NSDictionary(dictionary: self.parameters)
        let rhsParams = NSDictionary(dictionary: routeResult.parameters)
        
        var optionsAreEqual = false
        
        if self.routingOption == nil && routeResult.routingOption == nil {
            return true
        } else if let routingOption = self.routingOption {
            optionsAreEqual = routingOption.isEqual(otherOption:routeResult.routingOption)
        }
        
        return self.routePattern == routeResult.routePattern &&
            lhsParams == rhsParams &&
        optionsAreEqual
        
    }
    
}
