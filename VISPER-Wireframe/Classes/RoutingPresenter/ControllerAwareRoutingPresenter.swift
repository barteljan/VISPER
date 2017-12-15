//
//  File.swift
//  VISPER-Wireframe
//
//  Created by bartel on 07.12.17.
//

import Foundation
import UIKit
import VISPER_Core

protocol ControllerContainerAwareRoutingPresenter : RoutingPresenter {
    var controllerContainer : ControllerContainer {get}
}

open class DefaultControllerContainerAwareRoutingPresenter : ControllerContainerAwareRoutingPresenter {
    
    open let controllerContainer : ControllerContainer
    
    public init(controllerContainer : ControllerContainer){
        self.controllerContainer = controllerContainer
    }
    
    /// Is this presenter responsible for presenting a given routing option
    ///
    /// - Parameter option: a given routing option
    /// - Returns: true if it is responsible, false if not
    open func isResponsible(routeResult: RouteResult) -> Bool {
        fatalError("implement me in your sub class")
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
    open func present(controller: UIViewController,
                     routeResult: RouteResult,
                       wireframe: Wireframe,
                        delegate: RoutingDelegate,
                      completion: @escaping () -> ()) throws {
        fatalError("implement me in your sub class")
    }
}
