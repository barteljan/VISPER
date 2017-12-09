//
//  RoutingDelegateObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core


@objc open class RoutingDelegateObjc : NSObject, RoutingDelegate {
    
    public let routingDelegate : RoutingDelegate
    
    public init(routingDelegate : RoutingDelegate) {
        self.routingDelegate = routingDelegate
        super.init()
    }
    
    open func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?) {
        self.routingDelegate.add(routingObserver: routingObserver,
                                        priority: priority,
                                    routePattern: routePattern)
    }
    
    open func willPresent(controller: UIViewController,
                         routeResult:  RouteResult,
                    routingPresenter: RoutingPresenter?,
                           wireframe: Wireframe) throws {
        try self.routingDelegate.willPresent(controller: controller,
                                            routeResult: routeResult,
                                       routingPresenter: routingPresenter,
                                              wireframe: wireframe)
    }
    
    
    open func didPresent( controller: UIViewController,
                     routeResult:  RouteResult,
                     routingPresenter: RoutingPresenter?,
                     wireframe: Wireframe) {
        self.didPresent(      controller: controller,
                             routeResult: routeResult,
                        routingPresenter: routingPresenter,
                               wireframe: wireframe)
    }
    
}

