//
//  ControllerProviderObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Core

@objc public protocol ControllerProviderObjcType {
    
    func isResponsible(routeResult: RouteResultObjc) -> Bool
    func makeController(routeResult: RouteResultObjc) throws -> UIViewController
    
}

@objc open class ControllerProviderObjc : NSObject,ControllerProvider,ControllerProviderObjcType{
   
    public let controllerProvider : ControllerProvider?
    public let controllerProviderObjc : ControllerProviderObjcType?
    
    public init(controllerProvider : ControllerProvider) {
        self.controllerProvider = controllerProvider
        self.controllerProviderObjc = nil
        super.init()
    }
    
    @objc public init(controllerProvider : ControllerProviderObjcType) {
        
        if let controllerProvider = controllerProvider as? ControllerProviderObjc {
            self.controllerProvider = controllerProvider.controllerProvider
            self.controllerProviderObjc = nil
        } else {
            self.controllerProviderObjc = controllerProvider
            self.controllerProvider = nil
        }
        
        super.init()
    }
    
    
    open func isResponsible(routeResult: RouteResult) -> Bool {
        
        guard controllerProvider != nil || controllerProviderObjc != nil else {
            fatalError("there should be a controllerProvider or a controllerProviderObjc")
        }
        
        if let controllerProvider = self.controllerProvider {
            return controllerProvider.isResponsible(routeResult: routeResult)
        } else if let controllerProviderObjc = self.controllerProviderObjc {
            let routeResultObjC = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            return controllerProviderObjc.isResponsible(routeResult: routeResultObjC)
        }
        
        return false
        
    }
    
    @objc open func isResponsible(routeResult: RouteResultObjc) -> Bool {
        
        guard controllerProvider != nil || controllerProviderObjc != nil else {
            fatalError("there should be a controllerProvider or a controllerProviderObjc")
        }
        
        if let controllerProvider = self.controllerProvider {
            return controllerProvider.isResponsible(routeResult: routeResult)
        } else if let controllerProviderObjc = self.controllerProviderObjc {
            return controllerProviderObjc.isResponsible(routeResult: routeResult)
        }
        
        return false
        
    }
    
    public func makeController(routeResult: RouteResult) throws -> UIViewController {
        
        guard controllerProvider != nil || controllerProviderObjc != nil else {
            fatalError("there should be a controllerProvider or a controllerProviderObjc")
        }
        
        if let controllerProvider = self.controllerProvider {
            return try controllerProvider.makeController(routeResult:routeResult)
        } else if let controllerProviderObjc = self.controllerProviderObjc {
            let routeResultObjC = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            return try controllerProviderObjc.makeController(routeResult: routeResultObjC)
        }
        
        fatalError("there should be a controllerProvider or a controllerProviderObjc")
    }
    
    open func makeController(routeResult: RouteResultObjc) throws -> UIViewController {
        
        guard controllerProvider != nil || controllerProviderObjc != nil else {
            fatalError("there should be a controllerProvider or a controllerProviderObjc")
        }
        
        if let controllerProvider = self.controllerProvider {
            return try controllerProvider.makeController(routeResult:routeResult)
        } else if let controllerProviderObjc = self.controllerProviderObjc {
            return try controllerProviderObjc.makeController(routeResult: routeResult)
        }
        
        fatalError("there should be a controllerProvider or a controllerProviderObjc")
    }
    
}
