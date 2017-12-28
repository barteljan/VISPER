//
//  VISPERWireframe.swift
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Objc
import VISPER_Core

@objc open class VISPERWireframe: NSObject,IVISPERWireframe {
    
    open let wireframe: WireframeObjc
    let routingOptionConverter: RoutingOptionConverter
    
    public init(  wireframe: WireframeObjc,
     routingOptionConverter: RoutingOptionConverter = DefaultRoutingOptionConverter()) {
        self.wireframe = wireframe
        self.routingOptionConverter = routingOptionConverter
    }
    
    @objc public func addRoute(_ routePattern: String!) {
        do {
            try self.wireframe.add(routePattern: routePattern)
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    @objc public func addRoute(_ routePattern: String!, priority: UInt, handler handlerBlock: (([AnyHashable : Any]?) -> Bool)!) {
        
        do {
            try self.wireframe.add(priority: Int(priority),
                                   responsibleFor: { (routeResult: RouteResult) -> Bool in
                                    return routeResult.routePattern == routePattern!
            },
                                   handler: { (routeResult: RouteResult) in
                                       _ = handlerBlock(routeResult.parameters)
            })
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    @discardableResult
    @objc public func routeURL(_ URL: URL!) -> Bool {
        do {
            try self.wireframe.route(url: URL)
        } catch let error {
            print("Error: \(error)")
            return false
        }
        return true
    }
    
    @discardableResult
    @objc public func routeURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> Bool {
        do {
            try self.wireframe.route(url: URL,
                              parameters: self.convert(dict: parameters) ?? [:],
                                  option: nil,
                              completion: {})
        } catch let error {
            print("Error: \(error)")
            return false
        }
        return true
    }
    
    @objc func convert(dict: [AnyHashable : Any]?) -> [String : Any]? {
        
        guard let dict = dict else {
            return nil
        }
        
        var result = [String : Any]()
        
        for key in dict.keys {
            
            if let key = key as? String{
                result[key] = dict[key]
            }
            
        }
        
        return result
    }
    
    @discardableResult
    @objc public func routeURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!, options: IVISPERRoutingOption!) -> Bool {
        
        let option = try! self.routingOptionConverter.routingOption(visperRoutingOption: options)
        
        do {
            try self.wireframe.route(url: URL,
                              parameters: self.convert(dict: parameters) ?? [:],
                                  option: option,
                              completion: {})
        } catch let error {
            print("Error: \(error)")
            return false
        }
        return true
    }
    
    @objc public func controller(for URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> UIViewController? {
        return self.wireframe.controller(url: URL, parameters: self.convert(dict: parameters) ?? [:])
    }
    
    @objc public func canRouteURL(_ URL: URL!) -> Bool {
        do {
            return try self.wireframe.canRoute(url: URL!)
        } catch let error {
            print("Error: \(error)")
            return false
        }
    }
    
    @objc public func canRouteURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> Bool {
        do {
            return try self.wireframe.canRoute(url: URL, parameters: self.convert(dict: parameters) ?? [:])
        } catch let error {
            print("Error: \(error)")
            return false
        }
    }
    
    @objc public func addControllerServiceProvider(_ controllerServiceProvider: IVISPERControllerProvider!, withPriority priority: Int) {
        let wrapper = IVISPERControllerProviderWrapper(controllerProvider: controllerServiceProvider,
                                                       routingOptionConverter: self.routingOptionConverter)
        self.wireframe.add(controllerProvider: wrapper, priority: priority)
    }
    
    @objc public func add(_ presenter: IVISPERRoutingPresenter!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingPresenterWrapper(presenter: presenter,
                                        routingOptionConverter: self.routingOptionConverter,
                                                     wireframe: self)
        self.wireframe.add(routingPresenter: wrapper, priority: priority)
    }
    
    @objc public func add(_ observer: IVISPERRoutingObserver!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingObserverWrapper(observer: observer,
                                                    routingOptionConverter: self.routingOptionConverter,
                                                    wireframe: self)
        self.wireframe.add(routingObserver: wrapper, priority: priority, routePattern: nil)
    }
    
    @objc public func addRoutingOptionsServiceProvider(_ routingOptionsServiceProvider: IVISPERRoutingOptionsProvider!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingOptionsProviderWrapper(provider: routingOptionsServiceProvider, routingOptionConverter: self.routingOptionConverter)
        self.wireframe.add(optionProvider: wrapper)
    }
    
    @objc public func currentViewController() -> UIViewController? {
        return self.wireframe.topViewController
    }
    
    @objc public func back(_ animated: Bool, completion: (() -> Void)!) {
        self.wireframe.dismissTopViewController(animated: animated, completion: completion)
    }
    
}





