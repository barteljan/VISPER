//
//  VISPERWireframe.swift
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Objc
import VISPER_Core

public enum VISPERWireframeError: Error {
    case cannotConvert(routingOptionObjc: RoutingOptionObjc?)
}


@objc open class VISPERWireframe: NSObject,IVISPERWireframe {
    
    //MARK: convert options
    static var optionConverters = [RoutingOptionConverter]()
    
    public static func addRoutingOptionConverter(converter:RoutingOptionConverter){
        VISPERWireframe.optionConverters.append(converter)
    }
    
    @objc public static func addDefaultRoutingOptionConverter(){
        let converter = DefaultRoutingOptionConverter()
        VISPERWireframe.addRoutingOptionConverter(converter: converter)
    }
    
    
    public static func routingOption(visperRoutingOption: IVISPERRoutingOption?) throws -> RoutingOption? {
        
        guard let visperRoutingOption = visperRoutingOption else {
            return nil
        }
        
        let converters = VISPERWireframe.optionConverters
        for converter in converters.reversed(){
            if let option = try converter.routingOption(visperRoutingOption: visperRoutingOption) {
                return option
            }
        }
        return nil
    }
    
    public static func routingOption(routingOption: RoutingOption?) throws -> IVISPERRoutingOption? {
        
        guard let routingOption = routingOption else {
            return nil
        }
        
        let converters = VISPERWireframe.optionConverters
        for converter in converters.reversed(){
            if let option = try converter.routingOption(routingOption: routingOption) {
                return option
            }
        }
        return nil
    }
    
    @objc public static func routingOption(routingOptionObjc: RoutingOptionObjc?) throws -> IVISPERRoutingOption {
        
        let routingOptionObjcCopy = routingOptionObjc
        
        guard let routingOptionObjc = routingOptionObjc else {
            throw VISPERWireframeError.cannotConvert(routingOptionObjc: routingOptionObjcCopy)
        }
        
        let converters = VISPERWireframe.optionConverters
        for converter in converters.reversed(){
            if let option = try converter.routingOption(routingOption: routingOptionObjc.routingOption) {
                return option
            }
        }
        
        throw VISPERWireframeError.cannotConvert(routingOptionObjc: routingOptionObjc)
    }
    
    
    //Wrap WireframeObjc
    public let wireframe: WireframeObjc
    
    @objc public init(wireframe: WireframeObjc) {
        self.wireframe = wireframe
    }
    
    @objc open func addRoute(_ routePattern: String!) {
        do {
            try self.wireframe.add(routePattern: routePattern)
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    @objc open func addRoute(_ routePattern: String!, priority: UInt, handler handlerBlock: (([AnyHashable : Any]?) -> Bool)!) {
        
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
    @objc open func routeURL(_ URL: URL!) -> Bool {
        do {
            try self.wireframe.route(url: URL)
        } catch let error {
            print("Error: \(error)")
            return false
        }
        return true
    }
    
    @discardableResult
    @objc open func routeURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> Bool {
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
    @objc open func routeURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!, options: IVISPERRoutingOption!) -> Bool {
        
        let option = try! VISPERWireframe.routingOption(visperRoutingOption: options)
        
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
    
    @objc open func controller(for URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> UIViewController? {
        return self.wireframe.controller(url: URL, parameters: self.convert(dict: parameters) ?? [:])
    }
    
    @objc open func canRouteURL(_ URL: URL!) -> Bool {
        do {
            return try self.wireframe.canRoute(url: URL!)
        } catch let error {
            print("Error: \(error)")
            return false
        }
    }
    
    @objc open func canRouteURL(_ URL: URL!, withParameters parameters: [AnyHashable : Any]!) -> Bool {
        do {
            return try self.wireframe.canRoute(url: URL, parameters: self.convert(dict: parameters) ?? [:])
        } catch let error {
            print("Error: \(error)")
            return false
        }
    }
    
    @objc open func addControllerServiceProvider(_ controllerServiceProvider: IVISPERControllerProvider!, withPriority priority: Int) {
        let wrapper = IVISPERControllerProviderWrapper(controllerProvider: controllerServiceProvider)
        self.wireframe.add(controllerProvider: wrapper, priority: priority)
    }
    
    @objc open func add(_ presenter: IVISPERRoutingPresenter!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingPresenterWrapper(presenter: presenter,
                                                     wireframe: self)
        self.wireframe.add(routingPresenter: wrapper, priority: priority)
    }
    
    @objc open func add(_ observer: IVISPERRoutingObserver!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingObserverWrapper(observer: observer,
                                                    wireframe: self)
        self.wireframe.add(routingObserver: wrapper, priority: priority, routePattern: nil)
    }
    
    @objc open func addRoutingOptionsServiceProvider(_ routingOptionsServiceProvider: IVISPERRoutingOptionsProvider!, withPriority priority: Int) {
        let wrapper = IVISPERRoutingOptionsProviderWrapper(provider: routingOptionsServiceProvider)
        self.wireframe.add(optionProvider: wrapper)
    }
    
    @objc open func currentViewController() -> UIViewController? {
        return self.wireframe.topViewController
    }
    
    @objc open func back(_ animated: Bool, completion: (() -> Void)!) {
        self.wireframe.dismissTopViewController(animated: animated, completion: completion)
    }
    
}





