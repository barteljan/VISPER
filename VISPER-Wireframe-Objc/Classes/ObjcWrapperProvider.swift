//
//  WireFrameToObjcWrapper.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core

public class ObjcWrapper {
    public static var wrapperProvider : ObjcWrapperProvider = DefaultObjcWrapperProvider()
}

public protocol ObjcWrapperProvider {
    
    func routingOption(routingOption: RoutingOption) -> RoutingOptionObjc
    func routeResult(routeResult: RouteResult) -> RouteResultObjc
    func wireframe(wireframe: Wireframe) -> WireframeObjc
    func routingPresenter(presenter: RoutingPresenter) -> RoutingPresenterObjc
    func routingDelegate(delegate: RoutingDelegate) -> RoutingDelegateObjc
    
}

open class DefaultObjcWrapperProvider: ObjcWrapperProvider{
    
    open func routingOption(routingOption: RoutingOption) -> RoutingOptionObjc {
        return RoutingOptionObjc(routingOption: routingOption)
    }
    
    open func routeResult(routeResult: RouteResult) -> RouteResultObjc {
        return RouteResultObjc(routeResult: routeResult)
    }
    
    open func wireframe(wireframe: Wireframe) -> WireframeObjc {
        return WireframeObjc(wireframe: wireframe)
    }
    
    open func routingPresenter(presenter: RoutingPresenter) -> RoutingPresenterObjc {
        return RoutingPresenterObjc(routingPresenter: presenter)
    }
    
    open func routingDelegate(delegate: RoutingDelegate) -> RoutingDelegateObjc {
        return RoutingDelegateObjc(routingDelegate: delegate)
    }
    
    
}
