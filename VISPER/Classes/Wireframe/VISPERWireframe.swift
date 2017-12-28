//
//  VISPERWireframe.swift
//  JLRoutes
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
    
    @objc public func removeRoute(_ routePattern: String!) {
        fatalError("Cannot call removeRoute(routePattern:) in this visper version")
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
    
    @objc public func routeURL(_ URL: URL!) -> Bool {
        do {
            try self.wireframe.route(url: URL)
        } catch let error {
            print("Error: \(error)")
            return false
        }
        return true
    }
    
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
    
    @objc public func printRoutingTable() -> String! {
        return "Cannot print routing table in this visper version"
    }
    
    @objc public func globalRoutes() -> IVISPERWireframe! {
        fatalError("Cannot call globalRoutes in this visper version")
    }
    
    @objc public func routes(forScheme scheme: String!) -> IVISPERWireframe! {
        fatalError("Cannot call routes(forScheme:) in this visper version")
    }
    
    @objc public func unregisterRouteScheme(_ scheme: String!) {
        fatalError("Cannot call unregisterRouteScheme(scheme:) in this visper version")
    }
    
    @objc public func serviceProvider() -> IVISPERWireframeServiceProvider! {
        fatalError("Cannot call serviceProvider in this visper version")
    }
    
    @objc public func setServiceProvider(_ serviceProvider: IVISPERWireframeServiceProvider!) {
        
    }
    
    @objc public func addControllerServiceProvider(_ controllerServiceProvider: IVISPERControllerProvider!, withPriority priority: Int) {
        let wrapper = IVISPERControllerProviderWrapper(controllerProvider: controllerServiceProvider,
                                                       routingOptionConverter: self.routingOptionConverter)
        self.wireframe.add(controllerProvider: wrapper, priority: priority)
    }
    
    @objc public func removeControllerServiceProvider(_ controllerServiceProvider: IVISPERControllerProvider!) {
        fatalError("Cannot call removeControllerServiceProvider(controllerServiceProvider:) in this visper version")
    }
    
    @objc public func controllerServiceProviders() -> [Any]! {
        fatalError("Cannot call controllerServiceProviders() in this visper version")
    }
    
    @objc public func add(_ presenter: IVISPERRoutingPresenter!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingPresenterWrapper(presenter: presenter,
                                        routingOptionConverter: self.routingOptionConverter,
                                                     wireframe: self)
        self.wireframe.add(routingPresenter: wrapper, priority: priority)
    }
    
    @objc public func remove(_ presenter: IVISPERRoutingPresenter!) {
        fatalError("Cannot call remove(presenter:) in this visper version")
    }
    
    @objc public func routingPresenters() -> [Any]! {
        fatalError("Cannot call routingPresenters() in this visper version")
    }
    
    @objc public func add(_ observer: IVISPERRoutingObserver!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingObserverWrapper(observer: observer,
                                                    routingOptionConverter: self.routingOptionConverter,
                                                    wireframe: self)
        self.wireframe.add(routingObserver: wrapper, priority: priority, routePattern: nil)
    }
    
    @objc public func remove(_ observer: IVISPERRoutingObserver!) {
        fatalError("Cannot call remove(observer:) in this visper version")
    }
    
    @objc public func routingObservers() -> [Any]! {
        fatalError("Cannot call routingObservers() in this visper version")
    }
    
    @objc public func addRoutingOptionsServiceProvider(_ routingOptionsServiceProvider: IVISPERRoutingOptionsProvider!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingOptionsProviderWrapper(provider: routingOptionsServiceProvider, routingOptionConverter: self.routingOptionConverter)
        self.wireframe.add(optionProvider: wrapper)
    }
    
    @objc public func removeRoutingOptionsServiceProvider(_ routingOptionsServiceProvider: IVISPERRoutingOptionsProvider!) {
        fatalError("Cannot call removeRoutingOptionsServiceProvider(routingOptionsServiceProvider:) in this visper version")
    }
    
    @objc public func routingOptionsServiceProviders() -> [Any]! {
        fatalError("Cannot call routingOptionsServiceProviders() in this visper version")
    }
    
    @objc public func addChildWireframe(_ wireframe: IVISPERWireframe!) {
        fatalError("Cannot call addChildWireframe(wireframe:) in this visper version")
    }
    
    @objc public func removeChildWireframe(_ wireframe: IVISPERWireframe!) {
        fatalError("Cannot call removeChildWireframe(wireframe:) in this visper version")
    }
    
    @objc public func hasChildWireframe(_ wireframe: IVISPERWireframe!) -> Bool {
        return false
    }
    
    @objc public func hasDescendantWireframe(_ wireframe: IVISPERWireframe!) -> Bool {
        return false
    }
    
    @objc public var unmatchedURLHandler: ((IVISPERWireframe?, URL?, [AnyHashable : Any]?) -> Bool)!
    
    @objc public func empty() -> IVISPERWireframe! {
        fatalError("Cannot call empty() in this visper version")
    }
    
    @objc public func setRoutingOptionsFactory(_ factory: IVISPERRoutingOptionsFactory!) {
        fatalError("Cannot call setRoutingOptionsFactory(factory:) in this visper version")
    }
    
    @objc public func routingOptionsFactory() -> IVISPERRoutingOptionsFactory! {
        fatalError("Cannot call routingOptionsFactory() in this visper version")
    }
    
    @objc public func currentViewController() -> UIViewController? {
        return self.wireframe.topViewController
    }
    
    @objc public func setCurrentViewController(_ controller: UIViewController!) {
        fatalError("Cannot call setCurrentViewController in this visper version")
    }
    
    @objc public func back(_ animated: Bool, completion: (() -> Void)!) {
        self.wireframe.dismissTopViewController(animated: animated, completion: completion)
    }
    
}





