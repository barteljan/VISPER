//
//  RouteResultHandler.swift
//
//  Created by bartel on 25.12.17.
//

import Foundation
import VISPER_Core

public protocol RouteResultHandler {
    
    func handleRouteResult(routeResult: RouteResult,
                           optionProvider: RoutingOptionProvider,
                           routingHandlerContainer: RoutingHandlerContainer,
                           controllerProvider: ComposedControllerProvider,
                           presenterProvider: PresenterProvider,
                           routingDelegate: RoutingDelegate,
                           routingObserver: RoutingObserver,
                           routingPresenter: RoutingPresenter,
                           wireframe: Wireframe,
                           completion: @escaping () -> Void) throws
    
    func controller(routeResult: RouteResult,
                    controllerProvider: ControllerProvider,
                    presenterProvider: PresenterProvider,
                    routingDelegate: RoutingDelegate,
                    routingObserver: RoutingObserver,
                    wireframe: Wireframe) throws -> UIViewController?
    
}
