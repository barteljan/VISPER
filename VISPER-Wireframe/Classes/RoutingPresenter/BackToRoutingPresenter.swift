//
//  BackToRoutingPresenter.swift
//  VISPER-Wireframe
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

public enum BackToRoutingPresenterError : Error {
    case didNotReceiveBackToRoutingOptionFor(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)
    case noNavigationControllerFound
}

public class BackToRoutingPresenter: DefaultControllerContainerAwareRoutingPresenter {
    /// Is this presenter responsible for presenting a given routing option
    ///
    /// - Parameter option: a given routing option
    /// - Returns: true if it is responsible, false if not
    open override func isResponsible(routeResult: RouteResult) -> Bool {
        let result = routeResult.routingOption is RoutingOptionBackTo
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
        
        let navigationController = self.controllerContainer.getController(matches: { controller in
            return controller is UINavigationController
        }) as? UINavigationController
        
        guard let routingOption = routeResult.routingOption as? RoutingOptionBackTo else {
            throw BackToRoutingPresenterError.didNotReceiveBackToRoutingOptionFor(controller: controller,
                                                                                 routeResult: routeResult,
                                                                                   wireframe: wireframe,
                                                                                    delegate: delegate)
        }
        
        try delegate.willPresent(controller: controller,
                                 routeResult: routeResult,
                                 routingPresenter: self,
                                 wireframe: wireframe)
        
        
        if let topController = wireframe.topViewController, let navigationController = navigationController {
            
            if let _ = topController.presentingViewController {
                var controllers = navigationController.viewControllers
                controllers.removeLast()
                controllers.append(controller)
                navigationController.viewControllers = controllers
            } else if navigationController.viewControllers.count > 1 {
                var controllers = navigationController.viewControllers
                controllers[navigationController.viewControllers.count-2] = controller
                navigationController.viewControllers = controllers
            } else {
                navigationController.setViewControllers([controller], animated: routingOption.animated)
            }
            
        } else if let navigationController = navigationController {
            navigationController.setViewControllers([controller], animated: routingOption.animated)
        }
        
        wireframe.dismissTopViewController(animated: routingOption.animated) {
            delegate.didPresent(controller: controller,
                                routeResult: routeResult,
                                routingPresenter: self,
                                wireframe: wireframe)
            completion()
        }
        
    }
}
