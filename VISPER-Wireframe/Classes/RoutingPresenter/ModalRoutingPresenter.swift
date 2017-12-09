//
//  ModalRoutingPresenter.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core

public enum ModalRoutingPresenterError : Error {
    case didNotReceiveModalRoutingOptionFor(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)
}


open class ModalRoutingPresenter : DefaultNavigationControllerBasedRoutingPresenter {
    
    /// Is this presenter responsible for presenting a given routing option
    ///
    /// - Parameter option: a given routing option
    /// - Returns: true if it is responsible, false if not
    open override func isResponsible(routeResult: RouteResult) -> Bool {
        return routeResult.routingOption is ModalRoutingOption
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
        guard let routingOption = routeResult.routingOption as? ModalRoutingOption else {
            throw ModalRoutingPresenterError.didNotReceiveModalRoutingOptionFor(controller: controller,
                                                                               routeResult: routeResult,
                                                                                 wireframe: wireframe,
                                                                                  delegate: delegate)
        }
        
        if let presentationStyle = routingOption.presentationStyle {
            controller.modalPresentationStyle = presentationStyle
        }
        
        if let transitionStyle = routingOption.transitionStyle {
            controller.modalTransitionStyle = transitionStyle
        }
        
        try delegate.willPresent(controller: controller,
                                 routeResult: routeResult,
                                 routingPresenter: self,
                                 wireframe: wireframe)
        
        let presentingController = self.navigationController
        
        presentingController?.present(controller,
                                      animated: true,
                                      completion: {
                                        delegate.didPresent(controller: controller,
                                                           routeResult: routeResult,
                                                      routingPresenter: self,
                                                             wireframe: wireframe)
                                        completion()
        })
        
    }
}
