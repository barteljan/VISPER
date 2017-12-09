//
//  RouteMatcher.swift
//  Pods-SwiftyVISPER_Example
//
//  Created by bartel on 19.11.17.
//

import Foundation
import VISPER_Wireframe_Core

/// An instance resolving urls to route patterns returning RouteResults
public protocol Router {
    
    /// Add a route pattern to your router
    ///
    /// - Parameter routePattern: a route pattern defining
    /// - Throws: throws errors for wrong formatted patterns
    func add(routePattern: String) throws
    
    
    /// Route for an given url
    ///
    /// - Parameter url: a url
    /// - Returns: a RouteResult if the router can resolve the url, nil otherwise
    /// - Throws: throws routing errors if they occour
    func route(url: URL, parameters: [String: Any]?, routingOption: RoutingOption?) throws ->  RouteResult?
    
    /// Route for an given url
    ///
    /// - Parameter url: a url
    /// - Returns: a RouteResult if the router can resolve the url, nil otherwise
    /// - Throws: throws routing errors if they occour
    func route(url: URL, parameters: [String: Any]?) throws ->  RouteResult?
    
    /// Route for an given url
    ///
    /// - Parameter url: a url
    /// - Returns: a RouteResult if the router can resolve the url, nil otherwise
    /// - Throws: throws routing errors if they occour
    func route(url: URL) throws ->  RouteResult?
}



