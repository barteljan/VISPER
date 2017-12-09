//
//  DefaultRoutingHandlerContainer.swift
//  VISPER-Wireframe-Core
//
//  Created by bartel on 25.11.17.
//

import Foundation
import VISPER_Wireframe_Core

open class DefaultRoutingHandlerContainer : RoutingHandlerContainer {
    
    var routeHandlers : [RouteHandlerWrapper]
    
    public init() {
        self.routeHandlers = [RouteHandlerWrapper]()
    }
    
    /// Register a handler for a route pattern
    /// The handler will be called if a route matches your route pattern.
    /// (you dont't have to add your pattern manually in this case)
    /// - Parameters:
    ///   - priority: The priority for calling your handler, higher priorities are called first. (Defaults to 0)
    ///   - responsibleFor: nil if this handler should be registered for every routing option, or a spec
    ///   - handler: A handler called when a route matches your route pattern
    open func add( priority: Int,
                   responsibleFor: @escaping (RouteResult) -> Bool,
                   handler: @escaping RoutingHandler) throws {
        let wrapper = RouteHandlerWrapper(priority: priority,
                                          isResponsible: responsibleFor,
                                          handler: handler)
        self.addWrapper(wrapper: wrapper)
    }
    
    
    /// Returns the priority of the highest registered handler responsible for this RouteResult, RoutingOption combination
    ///
    /// - Parameters:
    ///   - routeResult: a RouteResult
    ///   - routingOption: a RoutingOption
    /// - Returns: priority of the highest registered handler
    open func priorityOfHighestResponsibleProvider(routeResult: RouteResult) -> Int? {
        for wrapper in self.routeHandlers {
            if wrapper.isResponsible(routeResult) {
                return wrapper.priority
            }
        }
        
        return nil
    }
    
    /// Returns the registered handler with the highest priority responsible for this RouteResult, RoutingOption combination
    ///
    /// - Parameters:
    ///   - routeResult: a RouteResult
    ///   - routingOption: a RoutingOption
    /// - Returns: a routing handler if some is registered
    open func handler(routeResult: RouteResult) -> RoutingHandler? {
        
        for wrapper in self.routeHandlers {
            if wrapper.isResponsible(routeResult) {
                return wrapper.handler
            }
        }
        
        return nil
        
    }
    
    //MARK: some helpers
    
    struct RouteHandlerWrapper {
        let priority : Int
        let isResponsible: (RouteResult) -> Bool
        let handler : (_ routeResult: RouteResult) -> Void
    }
    
    func addWrapper(wrapper: RouteHandlerWrapper) {
        self.routeHandlers.append(wrapper)
        self.routeHandlers.sort { (wrapper1, wrapper2) -> Bool in
            return wrapper1.priority > wrapper2.priority
        }
    }
    
}
