//
//  Wireframe.swift
//  Pods-SwiftyVISPER_Example
//
//  Created by bartel on 17.11.17.
//

import Foundation

public protocol Wireframe {
    
    /// Check if a route pattern matching this url was added to the wireframe.
    /// Be careful, if you don't route to a handler (but to a controller),
    /// it's possible that no ControllerProvider or RoutingOptionProvider for this controller exists.
    ///
    /// - Parameters:
    ///   - url: the url to check for resolution
    ///   - parameters: the parameters (data) given to the controller
    /// - Returns: Can the wireframe find a route for the given url
    func canRoute(   url: URL,
                     parameters: [String : Any],
                     option: RoutingOption?) throws -> Bool
    
    /// Route to a new route presenting a view controller
    ///
    /// - Parameters:
    ///   - url: the route of the view controller to be presented
    ///   - option: how should your view controller be presented
    ///   - parameters: a dictionary of parameters (data) send to the presented view controller
    ///   - completion: function called when the view controller was presented
    /// - Throws: throws an error when no controller and/or option provider can be found.
    func route(url: URL,
               parameters: [String : Any],
               option: RoutingOption?,
               completion: @escaping () -> Void) throws
    
    /// Return the view controller for a given url
    ///
    /// - Parameters:
    ///   - url: url
    ///   - parameters: parameters
    /// - Returns: nil if no controller was found, the found controller otherwise
    func controller(url: URL,
                    parameters: [String : Any]) throws -> UIViewController?
    
    /// Register a route pattern for routing.
    /// You have to register a route pattern to allow the wireframe matching it.
    /// This is done automatically if you are using a ViewFeature from SwiftyVISPER as ControllerProvider.
    ///
    /// - Parameters:
    ///   - pattern: the route pattern to register
    func add(routePattern: String) throws
    
    /// Register a handler for a route pattern
    /// The handler will be called if a route matches your route pattern.
    /// (you dont't have to add your pattern manually in this case)
    /// - Parameters:
    ///   - priority: The priority for calling your handler, higher priorities are called first. (Defaults to 0)
    ///   - responsibleFor: nil if this handler should be registered for every routing option, or a spec
    ///   - handler: A handler called when a route matches your route pattern
    func add( priority: Int,
              responsibleFor: @escaping (_ routeResult: RouteResult) -> Bool,
              handler: @escaping RoutingHandler) throws
    
    /// Add an instance providing a controller for a route
    ///
    /// - Parameters:
    ///   - controllerProvider: instance providing a controller
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    func add(controllerProvider: ControllerProvider, priority: Int)
    
    /// Add an instance providing routing options for a route
    ///
    /// - Parameters:
    ///   - optionProvider: instance providing routing options for a route
    ///   - priority: The priority for calling your provider, higher priorities are called last. (Defaults to 0)
    func add(optionProvider: RoutingOptionProvider, priority: Int)
    
    /// Add an instance observing controllers before they are presented
    ///
    /// - Parameters:
    ///   - routingObserver: An instance observing controllers before they are presented
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    ///   - routePattern: The route pattern to call this observer, the observer is called for every route if this pattern is nil
    func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?)

    /// Add an instance responsible for presenting view controllers.
    /// It will be triggert after the wireframe resolves a route
    ///
    /// - Parameters:
    ///    - routingPresenter: An instance responsible for presenting view controllers
    ///    - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
     func add(routingPresenter: RoutingPresenter,priority: Int)
}

public extension Wireframe {
    
    public func canRoute(   url: URL,
                     parameters: [String : Any] = [:]) throws -> Bool {
        return try self.canRoute(url: url, parameters: parameters, option: nil)
    }
    
    public func canRoute(   url: URL,
                            option: RoutingOption? = nil) throws -> Bool {
        return try self.canRoute(url: url, parameters: [:], option: option)
    }
    
    public func route(url: URL,
                      option: RoutingOption? = nil,
                      completion: @escaping () -> Void = {}) throws {
        try self.route(url: url, parameters: [:], option: option, completion: completion)
    }
    
    public func route(url: URL,
                      parameters: [String : Any] = [:],
                      completion: @escaping () -> Void = {}) throws {
        try self.route(url: url, parameters: parameters, option: nil, completion: completion)
    }
    
    public func controller(url: URL) throws -> UIViewController? {
        return try self.controller(url: url, parameters: [:])
    }
    
    public func add(responsibleFor: @escaping (_ routeResult: RouteResult) -> Bool,
                           handler: @escaping RoutingHandler) throws {
        try self.add(priority: 0, responsibleFor: responsibleFor, handler: handler)
    }
    
    public func add(controllerProvider: ControllerProvider) {
        self.add(controllerProvider: controllerProvider, priority: 0)
    }
    
    public func add(optionProvider: RoutingOptionProvider) {
        self.add(optionProvider: optionProvider, priority: 0)
    }
    
    public func add(routingObserver: RoutingObserver, routePattern: String?) {
        self.add(routingObserver: routingObserver, priority: 0, routePattern:routePattern)
    }
    
    public func add(routingObserver: RoutingObserver, priority: Int = 0) {
        self.add(routingObserver: routingObserver, priority: priority, routePattern:nil)
    }
    
    public func add(routingPresenter: RoutingPresenter) {
        self.add(routingPresenter: routingPresenter, priority: 0)
    }
}
