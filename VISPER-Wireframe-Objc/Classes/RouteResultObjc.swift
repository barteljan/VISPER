//
//  RouteResultObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core

@objc public protocol RouteResultObjcType {
    var routePattern: String {get}
    var routingOptionObjc: RoutingOptionObjc? {get set}
    var parameters: [String : Any] {get}
}


@objc open class RouteResultObjc: NSObject, RouteResult, RouteResultObjcType {
    
    public var routeResult: RouteResult?
    public var routeResultObjc: RouteResultObjcType?

    public init(routeResult: RouteResult) {
        self.routeResult = routeResult
        self.routeResultObjc = nil
        
    }
    
    @objc public var routePattern: String {
        if let pattern = self.routeResult?.routePattern {
            return pattern
        }
        
        if let pattern = self.routeResultObjc?.routePattern {
            return pattern
        }
        
        fatalError("routeResult or routeResultObjc should be non nil")
    }
    
    public var routingOption: RoutingOption? {
        get {
            if let routingOption = self.routeResult?.routingOption {
                return routingOption
            }
            
            if let routingOption = self.routeResultObjc?.routingOptionObjc?.routingOption {
                return routingOption
            }
            
            return nil
        }
        set {
            guard let option = newValue else {
                self.routeResult?.routingOption = nil
                self.routeResultObjc?.routingOptionObjc = nil
                return
            }
            
            self.routeResult?.routingOption = option
            self.routeResultObjc?.routingOptionObjc = ObjcWrapper.wrapperProvider.routingOption(routingOption: option)
        }
    }
    
    @objc public var routingOptionObjc: RoutingOptionObjc? {
        get {
            
            if let routingOption = self.routeResult?.routingOption {
                return ObjcWrapper.wrapperProvider.routingOption(routingOption: routingOption)
            }
            
            if let routingOption = self.routeResultObjc?.routingOptionObjc {
                return routingOption
            }
            
            return nil
        }
        set {
            guard let option = newValue else {
                self.routeResult?.routingOption = nil
                self.routeResultObjc?.routingOptionObjc = nil
                return
            }
            
            self.routeResultObjc?.routingOptionObjc = option
            self.routingOption = option.routingOption
        }
    }
    
    @objc public var parameters: [String : Any] {
        
        if let routeResult = self.routeResult {
            return routeResult.parameters
        }
        
        if let routeResult = self.routeResultObjc {
            return routeResult.parameters
        }
        
         fatalError("routeResult or routeResultObjc should be non nil")
    }
    
    
}
