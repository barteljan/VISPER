//
//  WireframeObjc.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by Jan Bartel on 20.11.17.
//

import Foundation
import VISPER_Wireframe_Core

@objc open class WireframeObjc : NSObject, Wireframe {
    
    public let wireframe : Wireframe
    public var error : Error? = nil
    
    public init(wireframe : Wireframe) {
        self.wireframe = wireframe
    }
    
    open func canRoute(url: URL, parameters: [String : Any], option: RoutingOption?) throws -> Bool {
        return try self.wireframe.canRoute(url:url, parameters:parameters, option:option)
    }
    
    @objc open func canRoute(url: URL, parameters: [String : Any], option: RoutingOptionObjc?) -> Bool {
        self.error = nil
        do {
            return try self.wireframe.canRoute(url: url, parameters: parameters, option: option)
        } catch let error {
            self.error = error
            print("ERROR:\(error)")
            return false
        }
    }
    
    open func route(url: URL, parameters: [String : Any], option: RoutingOption?, completion: @escaping () -> Void) throws {
        try self.wireframe.route(url: url, parameters: parameters, option: option, completion: completion)
    }
    
    @objc open func route(url: URL, parameters: [String : Any], option: RoutingOptionObjc?, completion: @escaping () -> Void) throws{
        try self.wireframe.route(url: url, parameters: parameters, option: option?.routingOption, completion: completion)
    }
    
    @objc open func controller(url: URL, parameters: [String : Any]) -> UIViewController? {
        self.error = nil
        do{
            return try self.wireframe.controller(url: url, parameters: parameters)
        } catch let error {
            self.error = error
            print("ERROR:\(error)")
            return nil
        }
    }
    
    @objc open func add(routePattern: String) throws {
        try self.wireframe.add(routePattern: routePattern)
    }
    
    open func add(priority: Int, responsibleFor: @escaping (RouteResult) -> Bool, handler: @escaping RoutingHandler) throws {
        try self.wireframe.add(priority: priority, responsibleFor: responsibleFor, handler: handler)
    }
    
    @objc open func add(priority: Int, responsibleFor: @escaping (RouteResultObjc) -> Bool, handler: @escaping (RouteResultObjc) -> Void) throws {
        
        let responsible = { (routeResult: RouteResult) -> Bool in
            let objcResult = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            return responsibleFor(objcResult)
        }
        
        let routingHandler = {(routeResult: RouteResult) -> Void in
            let objcResult = ObjcWrapper.wrapperProvider.routeResult(routeResult: routeResult)
            handler(objcResult)
        }
        
        try self.wireframe.add(priority: priority, responsibleFor: responsible, handler: routingHandler)
    }
    
    open func add(controllerProvider: ControllerProvider, priority: Int) {
        self.wireframe.add(controllerProvider: controllerProvider,priority: priority)
    }
    
    @objc open func add(controllerProvider: ControllerProviderObjcType, priority: Int) {
        let wrapper = ControllerProviderObjc(controllerProvider: controllerProvider)
        self.wireframe.add(controllerProvider: wrapper, priority: priority)
    }
    
    open func add(optionProvider: RoutingOptionProvider, priority: Int) {
        self.wireframe.add(optionProvider: optionProvider)
    }
    
    @objc open func add(optionProvider: RoutingOptionProviderObjcType, priority: Int) {
        let wrapper = RoutingOptionProviderObjc(optionProvider: optionProvider)
        self.wireframe.add(optionProvider: wrapper)
    }
    
    open func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?) {
        self.wireframe.add(routingObserver: routingObserver, priority: priority, routePattern: routePattern)
    }
    
    @objc open func add(routingObserver: RoutingObserverObjcType, priority: Int, routePattern: String?) {
        let wrapper = RoutingObserverObjc(routingObserver: routingObserver)
        self.wireframe.add(routingObserver: wrapper, priority: priority, routePattern: routePattern)
    }
    
    open func add(routingPresenter: RoutingPresenter, priority: Int) {
        self.wireframe.add(routingPresenter: routingPresenter, priority: priority)
    }
    
    @objc open func add(routingPresenter: RoutingPresenterObjcType, priority: Int) {
        let wrapper = RoutingPresenterObjc(routingPresenter: routingPresenter)
        self.wireframe.add(routingPresenter: wrapper, priority: priority)
    }
}

