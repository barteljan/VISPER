//
//  DefaultRoutingPresenterDelegate.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 22.11.17.
//

import Foundation
import VISPER_Core
import VISPER_Objc

open class DefaultRoutingDelegate : RoutingDelegate {
    
    public init(){}

    /// An instance observing controllers before they are presented
    open var routingObserver: RoutingObserver?
    
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
        
        if let routingObserver = self.routingObserver {
            try routingObserver.willPresent(controller: controller,
                                           routeResult: routeResult,
                                      routingPresenter: routingPresenter,
                                             wireframe: wireframe)
        }
        
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
        
        if let routingObserver = self.routingObserver {

            routingObserver.didPresent(controller: controller,
                                      routeResult: routeResult,
                                 routingPresenter: routingPresenter,
                                        wireframe: wireframe)
            
        }
        
        controller.didRoute(ObjcWrapper.wrapperProvider.wireframe(wireframe: wireframe),
                            routeResult: ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult))
        
        //notify vc if it should be aware of it
        if let viewController = controller as? RoutingAwareViewController {
            viewController.didRoute(wireframe: wireframe,
                                 routeResult: routeResult)
        }
        
    }
    
}
