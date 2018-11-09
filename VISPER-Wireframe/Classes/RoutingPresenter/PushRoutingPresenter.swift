//
//  PushRoutingObserver.swift
//  VISPER-Core
//
//  Created by bartel on 07.12.17.
//

import Foundation
import VISPER_Core

public enum PushRoutingPresenterError : Error {
    case didNotReceivePushRoutingOptionFor(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)
    case noNavigationControllerFound
}

open class PushRoutingPresenter : DefaultControllerContainerAwareRoutingPresenter {
    
    /// Is this presenter responsible for presenting a given routing option
    ///
    /// - Parameter option: a given routing option
    /// - Returns: true if it is responsible, false if not
    open override func isResponsible(routeResult: RouteResult) -> Bool {
        let result = routeResult.routingOption is RoutingOptionPush
        return result
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
        
        guard let navigationController = self.controllerContainer.getController(matches: { controller in
            return controller is UINavigationController
        }) as? UINavigationController else {
            throw PushRoutingPresenterError.noNavigationControllerFound
        }
        
        guard let routingOption = routeResult.routingOption as? RoutingOptionPush else {
            throw PushRoutingPresenterError.didNotReceivePushRoutingOptionFor(controller: controller,
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
        
        if let transition = routingOption.animationTransition {
            UIView.beginAnimations("pushAnimationTransition", context: nil)
            UIView.setAnimationDuration(routingOption.animationDuration)
            navigationController.pushViewController(controller, animated: false)
            UIView.setAnimationTransition(transition, for: navigationController.view, cache: false)
            UIView.commitAnimations()
        } else {
            navigationController.pushViewController(controller, animated: routingOption.animated)
        }
        
        
        
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
