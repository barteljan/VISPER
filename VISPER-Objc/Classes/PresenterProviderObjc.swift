//
//  PresenterProviderObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 12.12.17.
//

import Foundation
import VISPER_Core

@objc public protocol PresenterProviderObjcType {
    
    func isResponsible(routeResult: RouteResultObjc,controller: UIViewController) -> Bool
    func makePresenters(routeResult: RouteResultObjc,controller: UIViewController) throws -> [PresenterObjc]
    
}

@objc open class PresenterProviderObjc : NSObject,PresenterProvider,PresenterProviderObjcType{
    
    open var presenterProvider : PresenterProvider?
    open var presenterProviderObjc : PresenterProviderObjcType?
    
    public init(presenterProvider : PresenterProvider) {
        self.presenterProvider = presenterProvider
        self.presenterProviderObjc = nil
        super.init()
    }
    
    @objc public init(presenterProvider : PresenterProviderObjcType) {
        
        if let presenterProvider = presenterProvider as? PresenterProviderObjc {
            self.presenterProvider = presenterProvider.presenterProvider
            self.presenterProviderObjc = nil
        } else {
            self.presenterProviderObjc = presenterProvider
            self.presenterProvider = nil
        }
        
        super.init()
    }
    
    
    open func isResponsible( routeResult: RouteResult, controller: UIViewController) -> Bool {
        
        guard presenterProvider != nil || presenterProviderObjc != nil else {
            fatalError("there should be a presenterProvider or a presenterProviderObjc")
        }
        
        if let presenterProvider = self.presenterProvider {
            return presenterProvider.isResponsible(routeResult: routeResult, controller: controller)
        } else if let presenterProviderObjc = self.presenterProviderObjc {
            let routeResultObjC = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            return presenterProviderObjc.isResponsible(routeResult: routeResultObjC, controller: controller)
        }
        
        return false
    }
    
    public func isResponsible(routeResult: RouteResultObjc, controller: UIViewController) -> Bool {
    
        guard presenterProvider != nil || presenterProviderObjc != nil else {
            fatalError("there should be a presenterProvider or a presenterProviderObjc")
        }
    
        if let presenterProvider = self.presenterProvider {
            return presenterProvider.isResponsible(routeResult: routeResult,controller: controller)
        } else if let presenterProviderObjc = self.presenterProviderObjc {
            return presenterProviderObjc.isResponsible(routeResult: routeResult,controller: controller)
        }
        
        return false
    }

    
    open func makePresenters( routeResult: RouteResult, controller: UIViewController) throws -> [Presenter]{
        
        guard presenterProvider != nil || presenterProviderObjc != nil else {
            fatalError("there should be a presenterProvider or a presenterProviderObjc")
        }
        
        if let presenterProvider = self.presenterProvider {
            return try presenterProvider.makePresenters(routeResult:routeResult,controller:controller)
        } else if let presenterProviderObjc = self.presenterProviderObjc {
            let routeResultObjC = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            return try presenterProviderObjc.makePresenters(routeResult: routeResultObjC, controller: controller)
        }
        
        return [Presenter]()
    }
    
    open func makePresenters(routeResult: RouteResultObjc,controller: UIViewController) throws -> [PresenterObjc] {
        
        guard presenterProvider != nil || presenterProviderObjc != nil else {
            fatalError("there should be a presenterProvider or a presenterProviderObjc")
        }
        
        if let presenterProvider = self.presenterProvider {
            return try presenterProvider.makePresenters(routeResult: routeResult, controller: controller).map({ presenter -> PresenterObjc in
                return PresenterObjc(presenter: presenter)
            })
        } else if let presenterProviderObjc = self.presenterProviderObjc {
            return try presenterProviderObjc.makePresenters(routeResult:routeResult,controller:controller)
        }
        
        return [PresenterObjc]()
    }


    
}
