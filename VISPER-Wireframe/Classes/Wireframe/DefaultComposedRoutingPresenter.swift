//
//  DefaultComposedRoutingPresenter.swift
//  VISPER-Wireframe
//
//  Created by bartel on 21.11.17.
//

import Foundation
import VISPER_Wireframe_Core

open class DefaultComposedRoutingPresenter : ComposedRoutingPresenter {
    
    var routingPresenters: [RoutingPresenterWrapper]
    
    public init(){
        self.routingPresenters = [RoutingPresenterWrapper]()
    }
    
    /// Add an instance responsible for presenting view controllers.
    /// It will be triggert after the wireframe resolves a route
    ///
    /// - Parameters:
    ///    - routingPresenter: An instance responsible for presenting view controllers
    ///    - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    public func add(routingPresenter: RoutingPresenter, priority: Int) {
        let wrapper = RoutingPresenterWrapper(priority: priority, routingPresenter: routingPresenter)
        self.addRoutingPresenterWrapper(wrapper: wrapper)
    }
    
    /// Is this presenter responsible for presenting a given routing option
    ///
    /// - Parameter option: a given routing option
    /// - Returns: true if it is responsible, false if not
     public func isResponsible(routeResult: RouteResult) -> Bool  {
        
        for wrapper in self.routingPresenters {
            if wrapper.routingPresenter.isResponsible(routeResult: routeResult) {
                return true
            }
        }
        return false
        
    }
    
    /// Present a view controller
    ///
    /// - Parameters:
    ///   - controller: The controller to be presented
    ///   - routePattern: The route pattern triggering this respresentation
    ///   - option: The routing option containing all presentation specific data
    ///   - parameters: The parameters (data) extraced from the route, or given by the sender
    ///   - wireframe: The wireframe triggering the presenter
    ///   - delegate: A delegate called for routing event handling
    public func present(controller: UIViewController,
                       routeResult: RouteResult,
                        wireframe: Wireframe,
                        delegate: RoutingDelegate,
                        completion: @escaping () -> ()) throws{
        
        for routingPresenterWrapper in self.routingPresenters {
            
            if routingPresenterWrapper.routingPresenter.isResponsible(routeResult: routeResult) {
                
                try routingPresenterWrapper.routingPresenter.present(controller: controller,
                                                                    routeResult: routeResult,
                                                                      wireframe: wireframe,
                                                                       delegate: delegate,
                                                                     completion: completion)
                return
            }
            
        }
        
    }
    
    internal struct RoutingPresenterWrapper {
        let priority : Int
        let routingPresenter : RoutingPresenter
    }
    
    func addRoutingPresenterWrapper(wrapper: RoutingPresenterWrapper) {
        self.routingPresenters.append(wrapper)
        self.routingPresenters.sort { (wrapper1, wrapper2) -> Bool in
            return wrapper1.priority > wrapper2.priority
        }
    }
    
}
