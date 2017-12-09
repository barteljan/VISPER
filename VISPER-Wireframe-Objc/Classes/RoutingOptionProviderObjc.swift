//
//  RoutingOptionProviderObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core

@objc public protocol RoutingOptionProviderObjcType {
    func option(routeResult: RouteResultObjc ) -> RoutingOptionObjc?
}

@objc open class RoutingOptionProviderObjc : NSObject, RoutingOptionProvider, RoutingOptionProviderObjcType{
    
    public let optionProvider : RoutingOptionProvider?
    public let optionProviderObjc : RoutingOptionProviderObjcType?
    
    
    public init(optionProvider : RoutingOptionProvider) {
        self.optionProvider = optionProvider
        self.optionProviderObjc = nil
        super.init()
    }
    
    public init(optionProvider : RoutingOptionProviderObjcType) {
        self.optionProviderObjc = optionProvider
        self.optionProvider = nil
        super.init()
    }


    open func option(routeResult: RouteResult) -> RoutingOption? {
    
        guard self.optionProvider != nil || self.optionProviderObjc != nil else {
            fatalError("optionProvider or optionProviderObjc should be non nil")
        }
    
        if let optionProvider = self.optionProvider {
            return optionProvider.option(routeResult: routeResult)
        } else if let optionProvider = self.optionProviderObjc {
            let wrappedRouteResult = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            
            if let option = optionProvider.option(routeResult: wrappedRouteResult) {
                return option.routingOption
            }else {
                return nil
            }
        }
        
        return nil
    }
    
    open func option(routeResult: RouteResultObjc ) -> RoutingOptionObjc? {
        
        guard self.optionProvider != nil || self.optionProviderObjc != nil else {
            fatalError("optionProvider or optionProviderObjc should be non nil")
        }
        
        if let optionProvider = self.optionProvider {
            
            guard let option = optionProvider.option(routeResult: routeResult) else {
                return nil
            }
            
            return ObjcWrapper.wrapperProvider.routingOption(routingOption: option)
            
        } else if let optionProvider = self.optionProviderObjc {
            
            let wrappedRouteResult = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            
            guard let option = optionProvider.option(routeResult: wrappedRouteResult) else {
                return nil
            }
            
            return ObjcWrapper.wrapperProvider.routingOption(routingOption: option)
        }
        return nil
    }
    
}
