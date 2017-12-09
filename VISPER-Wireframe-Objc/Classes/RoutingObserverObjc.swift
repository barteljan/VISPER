//
//  RoutingObserverObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core



@objc public protocol RoutingObserverObjcType {
    
    func willPresent( controller: UIViewController,
                      routeResult: RouteResultObjc,
                      routingPresenter: RoutingPresenterObjc?,
                      wireframe: WireframeObjc) throws
    
    func didPresent( controller: UIViewController,
                     routeResult: RouteResultObjc,
                     routingPresenter: RoutingPresenterObjc?,
                     wireframe: WireframeObjc)
    
}


@objc open class RoutingObserverObjc : NSObject,RoutingObserver,RoutingObserverObjcType {
    
    open let routingObserver : RoutingObserver?
    open let routingObserverObjc : RoutingObserverObjcType?
    
    public init(routingObserver : RoutingObserverObjcType){
        self.routingObserverObjc = routingObserver
        self.routingObserver = nil
        super.init()
    }
    
    public init(routingObserver : RoutingObserver){
        self.routingObserver = routingObserver
        self.routingObserverObjc = nil
        super.init()
    }
    
    open func willPresent( controller: UIViewController,
                          routeResult: RouteResult,
                     routingPresenter: RoutingPresenter?,
                            wireframe: Wireframe) throws {
        
        guard self.routingObserver != nil || self.routingObserverObjc != nil else {
            fatalError("routingObserver or should not be nil")
        }
        
        if let routingObserver = self.routingObserver {
            try routingObserver.willPresent(controller: controller,
                                           routeResult: routeResult,
                                      routingPresenter: routingPresenter,
                                             wireframe: wireframe)
        } else if let routingObserver = self.routingObserverObjc {
            
            var presenter : RoutingPresenterObjc?
            
            if let routingPresenter = routingPresenter {
                presenter = ObjcWrapper.wrapperProvider.routingPresenter(presenter: routingPresenter)
            }
            
            try routingObserver.willPresent(controller: controller,
                                           routeResult: ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult),
                                      routingPresenter: presenter,
                                             wireframe: ObjcWrapper.wrapperProvider.wireframe(wireframe: wireframe))
            
        }
        
    }
    
    open func willPresent( controller: UIViewController,
                          routeResult: RouteResultObjc,
                     routingPresenter: RoutingPresenterObjc?,
                            wireframe: WireframeObjc) throws {
        
        guard self.routingObserver != nil || self.routingObserverObjc != nil else {
            fatalError("routingObserver or should not be nil")
        }
        
        if let routingObserver = self.routingObserver {
            try routingObserver.willPresent(controller: controller,
                                            routeResult: routeResult,
                                            routingPresenter: routingPresenter?.routingPresenter,
                                            wireframe: wireframe.wireframe)
        } else if let routingObserver = self.routingObserverObjc {
            try routingObserver.willPresent(controller: controller,
                                            routeResult: routeResult,
                                            routingPresenter: routingPresenter,
                                            wireframe: wireframe)
            
        }
        
    }
    
    open func didPresent( controller: UIViewController,
                         routeResult: RouteResult,
                    routingPresenter: RoutingPresenter?,
                           wireframe: Wireframe)  {
        
        guard self.routingObserver != nil || self.routingObserverObjc != nil else {
            fatalError("routingObserver or should not be nil")
        }
        
        if let routingObserver = self.routingObserver {
            routingObserver.didPresent(controller: controller,
                                      routeResult: routeResult,
                                 routingPresenter: routingPresenter,
                                        wireframe: wireframe)
        } else if let routingObserver = self.routingObserverObjc {
            
            var presenter : RoutingPresenterObjc?
            
            if let routingPresenter = routingPresenter {
                presenter = ObjcWrapper.wrapperProvider.routingPresenter(presenter: routingPresenter)
            }
            
            routingObserver.didPresent(controller: controller,
                                      routeResult: ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult),
                                 routingPresenter: presenter,
                                        wireframe: ObjcWrapper.wrapperProvider.wireframe(wireframe: wireframe))
            
        }
        
    }
    
    open func didPresent( controller: UIViewController,
                         routeResult: RouteResultObjc,
                    routingPresenter: RoutingPresenterObjc?,
                           wireframe: WireframeObjc) {
        guard self.routingObserver != nil || self.routingObserverObjc != nil else {
            fatalError("routingObserver or should not be nil")
        }
        
        if let routingObserver = self.routingObserver {
            routingObserver.didPresent(controller: controller,
                                      routeResult: routeResult,
                                 routingPresenter: routingPresenter?.routingPresenter,
                                        wireframe: wireframe.wireframe)
        } else if let routingObserver = self.routingObserverObjc {
            routingObserver.didPresent(controller: controller,
                                      routeResult: routeResult,
                                 routingPresenter: routingPresenter,
                                        wireframe: wireframe)
            
        }
        
    }
    
}
