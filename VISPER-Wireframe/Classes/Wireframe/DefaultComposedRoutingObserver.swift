//
//  DefaultComposedRoutingObserver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 22.11.17.
//

import Foundation
import VISPER_Wireframe_Core

open class DefaultComposedRoutingObserver : ComposedRoutingObserver {
    
    var routingObservers: [RoutingObserverWrapper]
    
    public init() {
        self.routingObservers =  [RoutingObserverWrapper]()
    }
    
    /// Add an instance observing controllers before they are presented
    ///
    /// - Parameters:
    ///   - routingObserver: An instance observing controllers before they are presented
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    ///   - routePattern: The route pattern to call this observer, the observer is called for every route if this pattern is nil
    public func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?) {
        let wrapper = RoutingObserverWrapper(priority: priority, routePattern: routePattern, routingObserver: routingObserver)
        self.addRoutingObserverWrapper(wrapper: wrapper)
    }
    
    /// Event that indicates that a view controller will be presented
    ///
    /// - Parameters:
    ///   - controller: The view controller that will be presented
    ///   - routePattern: The route pattern triggering the presentation
    ///   - routingOption: The RoutingOption describing how the controller will be presented
    ///   - parameters: The parameters (data) extraced from the route, or given by the sender
    ///   - routingPresenter: The RoutingPresenter responsible for presenting the controller
    ///   - wireframe: The wireframe presenting the view controller
    public func willPresent(controller: UIViewController,
                            routeResult: RouteResult,
                            routingPresenter: RoutingPresenter?,
                            wireframe: Wireframe) throws {
        
        
        //notify all responsible routing observers that the presentation will occour soon
        for observerWrapper in self.routingObservers {
            if observerWrapper.routePattern == nil ||
               observerWrapper.routePattern == routeResult.routePattern {
                try observerWrapper.routingObserver.willPresent(controller: controller,
                                                               routeResult: routeResult,
                                                          routingPresenter: routingPresenter,
                                                                 wireframe: wireframe)
            }
        }
        
    }
    
    
    /// Event that indicates that a view controller was presented
    ///
    /// - Parameters:
    ///   - controller: The view controller that will be presented
    ///   - routePattern: The route pattern triggering the presentation
    ///   - routingOption: The RoutingOption describing how the controller will be presented
    ///   - parameters: The parameters (data) extraced from the route, or given by the sender
    ///   - routingPresenter: The RoutingPresenter responsible for presenting the controller
    ///   - wireframe: The wireframe presenting the view controller
    open func didPresent( controller: UIViewController,
                         routeResult: RouteResult,
                    routingPresenter: RoutingPresenter?,
                           wireframe: Wireframe)  {
        
        //notify all responsible routing observers that the view controller presentation did occure
        for observerWrapper in self.routingObservers {
            if observerWrapper.routePattern == nil ||
                observerWrapper.routePattern == routeResult.routePattern {
                observerWrapper.routingObserver.didPresent(   controller: controller,
                                                             routeResult: routeResult,
                                                        routingPresenter: routingPresenter,
                                                               wireframe: wireframe)
            }
        }
        
    }
    
    
    internal struct RoutingObserverWrapper {
        let priority : Int
        let routePattern : String?
        let routingObserver : RoutingObserver
    }
    
    func addRoutingObserverWrapper(wrapper: RoutingObserverWrapper) {
        self.routingObservers.append(wrapper)
        self.routingObservers.sort { (wrapper1, wrapper2) -> Bool in
            return wrapper1.priority > wrapper2.priority
        }
    }
    
}
