//
//  RootVCRoutingPresenter.swift
//  VISPER-Wireframe
//
//  Created by bartel on 08.12.17.
//

import Foundation

import VISPER_Wireframe_Core

public enum RootVCRoutingPresenterError : Error {
    case didNotReceiveRootVCRoutingOptionFor(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)
}

public class RootVCRoutingPresenter : DefaultNavigationControllerBasedRoutingPresenter {
    
    /// Is this presenter responsible for presenting a given routing option
    ///
    /// - Parameter option: a given routing option
    /// - Returns: true if it is responsible, false if not
    open override func isResponsible(routeResult: RouteResult) -> Bool {
        return routeResult.routingOption is RootVCRoutingOption
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
    open override func present(controller: UIViewController,
                               routeResult: RouteResult,
                               wireframe: Wireframe,
                               delegate: RoutingDelegate,
                               completion: @escaping () -> ()) throws {
        guard let routingOption = routeResult.routingOption as? RootVCRoutingOption else {
            throw RootVCRoutingPresenterError.didNotReceiveRootVCRoutingOptionFor(controller: controller,
                                                                                 routeResult: routeResult,
                                                                                   wireframe: wireframe,
                                                                                    delegate: delegate)
        }
        
        try delegate.willPresent(controller: controller,
                                 routeResult: routeResult,
                                 routingPresenter: self,
                                 wireframe: wireframe)
        
        if routingOption.animated {
            CATransaction.begin()
        }
        
        let controllers = [controller]
        self.navigationController?.setViewControllers(controllers, animated: false)
        
        if routingOption.animated {
            CATransaction.setCompletionBlock {
                delegate.didPresent(controller: controller,
                                    routeResult: routeResult,
                                    routingPresenter: self,
                                    wireframe: wireframe)
            }
        } else {
            delegate.didPresent(controller: controller,
                                routeResult: routeResult,
                                routingPresenter: self,
                                wireframe: wireframe)
        }
        
        if routingOption.animated {
            CATransaction.commit()
        }
        
    }
}
