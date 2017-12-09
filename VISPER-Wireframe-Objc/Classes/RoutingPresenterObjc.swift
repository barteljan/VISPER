//
//  RoutingPresenterObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core

@objc public protocol RoutingPresenterObjcType {
    func isResponsible(routeResult: RouteResultObjc) -> Bool
    func present(controller: UIViewController,
                 routeResult: RouteResultObjc,
                 wireframe: WireframeObjc,
                 delegate: RoutingDelegateObjc,
                 completion: @escaping () -> ()) throws
}


@objc open class RoutingPresenterObjc : NSObject, RoutingPresenter, RoutingPresenterObjcType{
  
    open let routingPresenter: RoutingPresenter?
    open let routingPresenterObjc: RoutingPresenterObjcType?
    
    
    public init(routingPresenter : RoutingPresenter){
        self.routingPresenter = routingPresenter
        self.routingPresenterObjc = nil
    }
    
    public init(routingPresenter : RoutingPresenterObjcType){
        self.routingPresenter = nil
        self.routingPresenterObjc = routingPresenter
    }
    
    open func isResponsible(routeResult: RouteResultObjc) -> Bool {
        
        guard self.routingPresenter != nil || self.routingPresenterObjc != nil else {
            fatalError("routingPresenter or routingPresenterObjc should be non nil")
        }
        
        if let routingPresenter = self.routingPresenter {
            return routingPresenter.isResponsible(routeResult: routeResult)
        } else if let routingPresenter = self.routingPresenterObjc {
            return routingPresenter.isResponsible(routeResult:routeResult)
        }
        
        return false
    }
    
    open func isResponsible(routeResult: RouteResult) -> Bool {
        
        guard self.routingPresenter != nil || self.routingPresenterObjc != nil else {
            fatalError("routingPresenter or routingPresenterObjc should be non nil")
        }
        
        if let routingPresenter = self.routingPresenter {
            return routingPresenter.isResponsible(routeResult: routeResult)
        } else if let routingPresenter = self.routingPresenterObjc {
            let routeResult = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            return routingPresenter.isResponsible(routeResult:routeResult)
        }
        
        return false
    }
    
    open func present(controller: UIViewController,
                     routeResult: RouteResultObjc,
                       wireframe: WireframeObjc,
                        delegate: RoutingDelegateObjc,
                      completion: @escaping () -> ()) throws {
        
        
        guard self.routingPresenter != nil || self.routingPresenterObjc != nil else {
            fatalError("routingPresenter or routingPresenterObjc should be non nil")
        }
        
        if let routingPresenter = self.routingPresenter {
            
            try routingPresenter.present(controller: controller,
                                        routeResult: routeResult,
                                          wireframe: wireframe.wireframe,
                                           delegate: delegate.routingDelegate,
                                         completion: completion)
            
        } else if let routingPresenter = self.routingPresenterObjc {
            
            try routingPresenter.present(controller: controller,
                                         routeResult: routeResult,
                                         wireframe: wireframe,
                                         delegate: delegate,
                                         completion: completion)
        }
        
        
        
    }
    
    
    
    public func present(controller: UIViewController,
                       routeResult: RouteResult,
                         wireframe: Wireframe,
                          delegate: RoutingDelegate,
                        completion: @escaping () -> ()) throws {
        
        guard self.routingPresenter != nil || self.routingPresenterObjc != nil else {
            fatalError("routingPresenter or routingPresenterObjc should be non nil")
        }
        
        if let routingPresenter = self.routingPresenter {
            try routingPresenter.present(controller: controller,
                                        routeResult: routeResult,
                                          wireframe: wireframe,
                                           delegate: delegate,
                                         completion: completion)
        } else if let routingPresenter = self.routingPresenterObjc {
            try routingPresenter.present(controller: controller,
                                        routeResult: ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult),
                                          wireframe: ObjcWrapper.wrapperProvider.wireframe(wireframe: wireframe),
                                           delegate: ObjcWrapper.wrapperProvider.routingDelegate(delegate: delegate),
                                         completion: completion)
        }
        
    }
        
}
