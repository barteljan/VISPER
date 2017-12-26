//
//  ComposedRoutingObserverDelegate.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 22.11.17.
//

import Foundation

public protocol RoutingDelegate {
    
    /// An instance observing controllers before they are presented
    var routingObserver: RoutingObserver? {get set}
    
    /// Event that indicates that a view controller will be presented
    ///
    /// - Parameters:
    ///   - controller: The view controller that will be presented
    ///   - routePattern: The route pattern triggering the presentation
    ///   - routingOption: The RoutingOption describing how the controller will be presented
    ///   - parameters: The parameters (data) extraced from the route, or given by the sender
    ///   - routingPresenter: The RoutingPresenter responsible for presenting the controller
    ///   - wireframe: The wireframe presenting the view controller
    func willPresent(controller: UIViewController,
                   routeResult:  RouteResult,
               routingPresenter: RoutingPresenter?,
                      wireframe: Wireframe) throws
    
    
    /// Event that indicates that a view controller was presented
    ///
    /// - Parameters:
    ///   - controller: The view controller that will be presented
    ///   - routePattern: The route pattern triggering the presentation
    ///   - routingOption: The RoutingOption describing how the controller will be presented
    ///   - parameters: The parameters (data) extraced from the route, or given by the sender
    ///   - routingPresenter: The RoutingPresenter responsible for presenting the controller
    ///   - wireframe: The wireframe presenting the view controller
    func didPresent( controller: UIViewController,
                    routeResult:  RouteResult,
               routingPresenter: RoutingPresenter?,
                      wireframe: Wireframe)
    
}
