//
//  VISPERWireframe.swift
//  Pods-SwiftyVISPER_Example
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Core
import VISPER_UIViewController

public enum DefaultWireframeError : Error {
    case noRoutingOptionFoundFor(routeResult: RouteResult)
    case canNotHandleRoute(routeResult: RouteResult)
    case noRoutingPresenterFoundFor(result: RouteResult)
    case noRoutePatternFoundFor(url: URL, parameters: [String : Any])
    case noControllerFor(routeResult: RouteResult)
}


open class DefaultWireframe : Wireframe {
    
    //MARK: internal properties
    
    let router: Router
    let composedOptionProvider: ComposedRoutingOptionProvider
    let composedRoutingPresenter: ComposedRoutingPresenter
    let composedControllerProvider: ComposedControllerProvider
    let composedPresenterProvider: ComposedPresenterProvider
    var routingDelegate: RoutingDelegate
    let routingHandlerContainer: RoutingHandlerContainer
    let composedRoutingObserver: ComposedRoutingObserver
    let routeResultHandler: RouteResultHandler
    
    //MARK: Initializer
    public init(       router : Router = DefaultRouter(),
        composedOptionProvider: ComposedRoutingOptionProvider = DefaultComposedRoutingOptionProvider(),
       routingHandlerContainer: RoutingHandlerContainer = DefaultRoutingHandlerContainer(),
    composedControllerProvider: ComposedControllerProvider = DefaultComposedControllerProvider(),
     composedPresenterProvider: ComposedPresenterProvider = DefaultComposedPresenterProvider(),
      composedRoutingPresenter: ComposedRoutingPresenter = DefaultComposedRoutingPresenter(),
               routingDelegate: RoutingDelegate = DefaultRoutingDelegate(),
       composedRoutingObserver: ComposedRoutingObserver = DefaultComposedRoutingObserver(),
            routeResultHandler: RouteResultHandler = DefaultRouteResultHandler()
      ){
        
        self.routingHandlerContainer = routingHandlerContainer
        self.composedOptionProvider = composedOptionProvider
        self.composedRoutingPresenter = composedRoutingPresenter
        self.routingDelegate = routingDelegate
        self.composedControllerProvider = composedControllerProvider
        self.composedPresenterProvider = composedPresenterProvider
        self.composedRoutingObserver = composedRoutingObserver
        self.routeResultHandler = routeResultHandler
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
        
        
        guard let routeResult = try self.router.route(url: url, parameters: parameters, routingOption: option) else {
            throw DefaultWireframeError.noRoutePatternFoundFor(url: url, parameters: parameters)
        }
        
        try self.routeResultHandler.handleRouteResult(routeResult: routeResult,
                                                   optionProvider: self.composedOptionProvider,
                                          routingHandlerContainer: self.routingHandlerContainer,
                                               controllerProvider: self.composedControllerProvider,
                                                presenterProvider: self.composedPresenterProvider,
                                                  routingDelegate: self.routingDelegate,
                                                  routingObserver: self.composedRoutingObserver,
                                                 routingPresenter: self.composedRoutingPresenter,
                                                        wireframe: self,
                                                       completion: completion)
        
        
     
        
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
        
        return try self.routeResultHandler.controller(routeResult: routeResult,
                                               controllerProvider: self.composedControllerProvider,
                                                presenterProvider: self.composedPresenterProvider,
                                                  routingDelegate: self.routingDelegate,
                                                  routingObserver: self.composedRoutingObserver,
                                                        wireframe: self)
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
    
    /// Add an instance providing a presenter for a route
    ///
    /// - Parameters:
    ///   - provider: instance providing a presenter
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    open func add(presenterProvider: PresenterProvider, priority: Int = 0) {
        self.composedPresenterProvider.add(provider: presenterProvider, priority: priority)
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
        self.composedRoutingObserver.add(routingObserver: routingObserver, priority: priority, routePattern: routePattern)
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
