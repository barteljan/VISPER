//
//  DefaultRoutingPresenterDelegate.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 22.11.17.
//

import Foundation
import VISPER_Wireframe_Core
import VISPER_Wireframe_Objc

open class DefaultRoutingDelegate : RoutingDelegate {
    
    
    let composedRoutingObserver : ComposedRoutingObserver
    
    public init(composedRoutingObserver : ComposedRoutingObserver = DefaultComposedRoutingObserver()) {
        self.composedRoutingObserver = composedRoutingObserver
    }
    
    /// Add an instance observing controllers before they are presented
    ///
    /// - Parameters:
    ///   - routingObserver: An instance observing controllers before they are presented
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    ///   - routePattern: The route pattern to call this observer, the observer is called for every route if this pattern is nil
    open func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?){
        self.composedRoutingObserver.add(routingObserver: routingObserver,
                                                priority: priority,
                                            routePattern: routePattern)
    }
    
    
    /// Event that indicates that a view controller will be presented
    ///
    /// - Parameters:
    ///   - controller: The view controller that will be presented
    ///   - routePattern: The route pattern triggering the presentation
    ///   - routingOption: The RoutingOption describing how the controller will be presented
    ///   - parameters: The parameters (data) extraced from the route, or given by the sender
    ///   - routingPresenter: The RoutingPresenter responsible for presenting the controller
    ///   - wireframe: The wireframe presenting the view controller
    open func willPresent(controller: UIViewController,
                         routeResult: RouteResult,
                    routingPresenter: RoutingPresenter?,
                           wireframe: Wireframe) throws {
        
        try self.composedRoutingObserver.willPresent(controller: controller,
                                                     routeResult: routeResult,
                                                     routingPresenter: routingPresenter,
                                                     wireframe: wireframe)
        
        controller.willRoute(ObjcWrapper.wrapperProvider.wireframe(wireframe: wireframe),
                             routeResult: ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult))
        
        //notify vc if it should be aware of it
        if let viewController = controller as? RoutingAwareViewController {
            viewController.willRoute(wireframe: wireframe,
                                   routeResult: routeResult)
        }
        
    }
    
    /// Event that indicates that a view controller was presented
    ///
    /// - Parameters:
    ///   - controller: The view controller that will be presented
    ///   - routePattern: The route pattern triggering the presentation
    ///   - routingOption: The RoutingOption describing how the controller will be presented
    ///   - parameters: The parameters (data) extraced from the route, or given by the sender
    ///   - routingPresenter: The RoutingPresenter responsible for presenting the controller
    ///   - wireframe: The wireframe presenting the view controller
    open func didPresent(controller: UIViewController,
                        routeResult: RouteResult,
                   routingPresenter: RoutingPresenter?,
                          wireframe: Wireframe) {
        
        self.composedRoutingObserver.didPresent(controller: controller,
                                                routeResult: routeResult,
                                                routingPresenter: routingPresenter,
                                                wireframe: wireframe)
        
        controller.didRoute(ObjcWrapper.wrapperProvider.wireframe(wireframe: wireframe),
                            routeResult: ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult))
        
        //notify vc if it should be aware of it
        if let viewController = controller as? RoutingAwareViewController {
            viewController.didRoute(wireframe: wireframe,
                                 routeResult: routeResult)
        }
        
    }
    
}
