//
//  VISPERWireframe.swift
//  Pods-SwiftyVISPER_Example
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Wireframe_Core
import VISPER_Wireframe_UIViewController

public enum DefaultWireframeError : Error {
    case noRoutingOptionFoundFor(routeResult: RouteResult)
    case canNotHandleRoute(routeResult: RouteResult)
    case noRoutingPresenterFoundFor(result: RouteResult)
    case noRoutePatternFoundFor(url: URL, parameters: [String : Any])
}


open class DefaultWireframe : Wireframe {
    
    //MARK: internal properties
    
    let router: Router
    let composedOptionProvider: ComposedRoutingOptionProvider
    let composedRoutingPresenter: ComposedRoutingPresenter
    let composedControllerProvider: ComposedControllerProvider
    let routingPresenterDelegate: RoutingDelegate
    let routingHandlerContainer: RoutingHandlerContainer
    
    //MARK: Initializer
    public init(       router : Router = DefaultRouter(),
        composedOptionProvider: ComposedRoutingOptionProvider = DefaultComposedRoutingOptionProvider(),
      composedRoutingPresenter: ComposedRoutingPresenter = DefaultComposedRoutingPresenter(),
               routingDelegate: RoutingDelegate = DefaultRoutingDelegate(),
       routingHandlerContainer: RoutingHandlerContainer = DefaultRoutingHandlerContainer(),
    composedControllerProvider: ComposedControllerProvider = DefaultComposedControllerProvider()){
        
        self.routingHandlerContainer = routingHandlerContainer
        self.composedOptionProvider = composedOptionProvider
        self.composedRoutingPresenter = composedRoutingPresenter
        self.routingPresenterDelegate = routingDelegate
        self.composedControllerProvider = composedControllerProvider
        self.router = router
    }
    
    //MARK: route
    
    /// Check if a route pattern matching this url was added to the wireframe.
    /// Be careful, if you don't route to a handler (but to a controller),
    /// it's possible that no ControllerProvider or RoutingOptionProvider for this controller exists.
    ///
    /// - Parameters:
    ///   - url: the url to check for resolution
    ///   - parameters: the parameters (data) given to the controller
    /// - Returns: Can the wireframe find a route for the given url
    public func canRoute(url: URL, parameters: [String : Any], option: RoutingOption?) throws -> Bool{
        
        if let _ = try self.router.route(url: url, parameters: parameters, routingOption: option) {
            return true
        }else {
            return false
        }
        
    }
    
    /// Route to a new route presenting a view controller
    ///
    /// - Parameters:
    ///   - url: the route of the view controller to be presented
    ///   - option: how should your view controller be presented (default is nil)
    ///   - parameters: a dictionary of parameters (data) send to the presented view controller (default is empty dict)
    ///   - completion: function called when the view controller was presented (default is empty completion)
    /// - Throws: throws an error when no controller and/or option provider can be found.
    open func route(url: URL,
             parameters: [String : Any] = [:],
                 option: RoutingOption? = nil,
             completion: @escaping () -> Void = {}) throws {
        
        
        guard var routeResult = try self.router.route(url: url, parameters: parameters, routingOption: option) else {
            throw DefaultWireframeError.noRoutePatternFoundFor(url: url, parameters: parameters)
        }
        
        //check if someone wants to modify your routing option
        let modifiedRoutingOption : RoutingOption? = self.composedOptionProvider.option(routeResult: routeResult)
        
        routeResult.routingOption = modifiedRoutingOption
        
        //check if there is a routing handler responsible for this RouteResult/RoutingOption combination
        let handlerPriority = self.routingHandlerContainer.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        
        //check if there is a controller provider responsible for this RouteResult/RoutingOption combination 
        let controllerPriority = self.composedControllerProvider.priorityOfHighestResponsibleProvider(routeResult: routeResult)
        
        //call handler and terminate if its priority is higher than the controllers provider
        if controllerPriority != nil && handlerPriority != nil {
            if handlerPriority! >= controllerPriority! {
                try self.callHandler(routeResult: routeResult, completion: completion)
                return
            }
        } else if controllerPriority == nil && handlerPriority != nil {
            try self.callHandler(routeResult: routeResult, completion: completion)
            return
        }
        
        //proceed with controller presentation if no handler with higher priority was found
        
        //check if a controller could be provided by the composedControllerProvider
        guard self.composedControllerProvider.isResponsible(routeResult: routeResult) else {
            throw DefaultWireframeError.canNotHandleRoute(routeResult: routeResult)
        }
        
        let controller = try self.composedControllerProvider.makeController(routeResult: routeResult)
        
        //check if we have a presenter responsible for this option
        guard self.composedRoutingPresenter.isResponsible(routeResult: routeResult) else {
            throw DefaultWireframeError.noRoutingPresenterFoundFor(result: routeResult)
        }
        
        //present view controller
        try self.composedRoutingPresenter.present(controller: controller,
                                             routeResult: routeResult,
                                               wireframe: self,
                                                delegate: self.routingPresenterDelegate,
                                              completion: completion)
        
        
     
        
    }
    
    func callHandler(routeResult: RouteResult, completion: @escaping () -> Void) throws{
        if let handler = self.routingHandlerContainer.handler(routeResult: routeResult) {
            handler(routeResult)
            completion()
            return
        }
        throw DefaultWireframeError.canNotHandleRoute(routeResult: routeResult)
    }
    
    /// Return the view controller for a given url
    ///
    /// - Parameters:
    ///   - url: url
    ///   - parameters: parameters
    /// - Returns: nil if no controller was found, the found controller otherwise
    open func controller(url: URL, parameters: [String : Any]) throws -> UIViewController? {
        
        let routingOption = DefaultGetControllerRoutingOption()
        
        guard let routeResult = try self.router.route(url: url, parameters: parameters, routingOption: routingOption) else {
            throw DefaultWireframeError.noRoutePatternFoundFor(url: url, parameters: parameters)
        }
        
        if self.composedControllerProvider.isResponsible(routeResult: routeResult) {
            
            let controller = try self.composedControllerProvider.makeController(routeResult: routeResult)
            
            try self.routingPresenterDelegate.willPresent(controller: controller,
                                                     routeResult: routeResult,
                                                routingPresenter: nil,
                                                       wireframe: self)
        
            self.routingPresenterDelegate.didPresent(controller: controller,
                                                    routeResult: routeResult,
                                               routingPresenter: nil,
                                                      wireframe: self)
        
            return controller
            
        }
        
        return nil
    }
    
    //MARK: Add dependencies
    
    /// Register a route pattern for routing.
    /// You have to register a route pattern to allow the wireframe matching it.
    /// This is done automatically if you are using a ViewFeature from SwiftyVISPER as ControllerProvider.
    ///
    /// - Parameters:
    ///   - pattern: the route pattern to register
    open func add(routePattern: String) throws{
        try self.router.add(routePattern: routePattern)
    }
    
    /// Register a handler for a route pattern
    /// The handler will be called if a route matches your route pattern.
    /// (you dont't have to add your pattern manually in this case)
    /// - Parameters:
    ///   - priority: The priority for calling your handler, higher priorities are called first. (Defaults to 0)
    ///   - responsibleFor: nil if this handler should be registered for every routing option, or a spec
    ///   - handler: A handler called when a route matches your route pattern
     public func add(priority: Int,
               responsibleFor: @escaping (RouteResult) -> Bool,
                      handler: @escaping RoutingHandler) throws {
        try self.routingHandlerContainer.add(priority: priority,
                                       responsibleFor: responsibleFor,
                                              handler: handler)
    }
    
    /// Add an instance providing a controller for a route
    ///
    /// - Parameters:
    ///   - controllerProvider: instance providing a controller
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    open func add(controllerProvider: ControllerProvider, priority: Int = 0) {
        self.composedControllerProvider.add(controllerProvider: controllerProvider, priority: priority)
    }
    
    /// Add an instance providing routing options for a route
    ///
    /// - Parameters:
    ///   - optionProvider: instance providing routing options for a route
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    open func add(optionProvider: RoutingOptionProvider, priority: Int = 0) {
        self.composedOptionProvider.add(optionProvider: optionProvider, priority: priority)
    }
    
    /// Add an instance observing controllers before they are presented
    ///
    /// - Parameters:
    ///   - routingObserver: An instance observing controllers before they are presented
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    ///   - routePattern: The route pattern to call this observer, the observer is called for every route if this pattern is nil
    open func add(routingObserver: RoutingObserver, priority: Int = 0, routePattern: String? = nil) {
        self.routingPresenterDelegate.add(routingObserver: routingObserver, priority: priority, routePattern: routePattern)
    }
    
    /// Add an instance responsible for presenting view controllers.
    /// It will be triggert after the wireframe resolves a route
    ///
    /// - Parameters:
    ///    - routingPresenter: An instance responsible for presenting view controllers
    ///    - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    open func add(routingPresenter: RoutingPresenter,priority: Int = 0) {
        self.composedRoutingPresenter.add(routingPresenter: routingPresenter, priority: priority)
    }
    
}
