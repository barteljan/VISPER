//
//  RoutingDelegateObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Core


@objc open class RoutingDelegateObjc : NSObject, RoutingDelegate {
    
    public var routingDelegate : RoutingDelegate
    
    /// An instance observing controllers before they are presented
    open var routingObserver: RoutingObserver? {
        set {
            self.routingDelegate.routingObserver = newValue
        }
        get {
            return self.routingDelegate.routingObserver
        }
    }
    
    public init(routingDelegate : RoutingDelegate) {
        self.routingDelegate = routingDelegate
        super.init()
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

