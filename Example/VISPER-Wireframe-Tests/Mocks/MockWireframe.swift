//
//  MockWireframe.swift
//  VISPER-Wireframe_Example
//
//  Created by bartel on 23.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

import VISPER_Wireframe_Core
import VISPER_Wireframe

class MockWireframe: NSObject, Wireframe {

    var invokedCanRoute = false
    var invokedCanRouteCount = 0
    var invokedCanRouteParameters: (url: URL, parameters: [String: Any], option: RoutingOption?)?
    var invokedCanRouteParametersList = [(url: URL, parameters: [String: Any], option: RoutingOption?)]()
    var stubbedCanRouteResult: Bool! = false

    func canRoute(url: URL, parameters: [String: Any], option: RoutingOption?) -> Bool {
        invokedCanRoute = true
        invokedCanRouteCount += 1
        invokedCanRouteParameters = (url, parameters, option)
        invokedCanRouteParametersList.append((url, parameters, option))
        return stubbedCanRouteResult
    }

    var invokedRoute = false
    var invokedRouteCount = 0
    var invokedRouteParameters: (url: URL, parameters: [String: Any], option: RoutingOption?)?
    var invokedRouteParametersList = [(url: URL, parameters: [String: Any], option: RoutingOption?)]()

    func route(url: URL, parameters: [String: Any], option: RoutingOption?, completion: @escaping () -> Void) {
        invokedRoute = true
        invokedRouteCount += 1
        invokedRouteParameters = (url, parameters, option)
        invokedRouteParametersList.append((url, parameters, option))
        completion()
    }

    var invokedController = false
    var invokedControllerCount = 0
    var invokedControllerParameters: (url: URL, parameters: [String: Any])?
    var invokedControllerParametersList = [(url: URL, parameters: [String: Any])]()
    var stubbedControllerResult: UIViewController!

    func controller(url: URL, parameters: [String: Any]) -> UIViewController? {
        invokedController = true
        invokedControllerCount += 1
        invokedControllerParameters = (url, parameters)
        invokedControllerParametersList.append((url, parameters))
        return stubbedControllerResult
    }

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (routePattern: String, Void)?
    var invokedAddParametersList = [(routePattern: String, Void)]()

    func add(routePattern: String) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (routePattern, ())
        invokedAddParametersList.append((routePattern, ()))
    }

    var invokedAddPriority = false
    var invokedAddPriorityCount = 0
    var invokedAddPriorityParameters: (priority: Int, Void)?
    var invokedAddPriorityParametersList = [(priority: Int, Void)]()
    var stubbedAddResponsibleForResult: (RouteResult, Void)?
    var stubbedAddHandlerResult: (RouteResult, Void)?

    func add(priority: Int, responsibleFor: @escaping (_ routeResult: RouteResult) -> Bool, handler: @escaping RoutingHandler) {
        invokedAddPriority = true
        invokedAddPriorityCount += 1
        invokedAddPriorityParameters = (priority, ())
        invokedAddPriorityParametersList.append((priority, ()))
        if let result = stubbedAddResponsibleForResult {
            _ = responsibleFor(result.0)
        }
        if let result = stubbedAddHandlerResult {
            handler(result.0)
        }
    }

    var invokedAddControllerProvider = false
    var invokedAddControllerProviderCount = 0
    var invokedAddControllerProviderParameters: (controllerProvider: ControllerProvider, priority: Int)?
    var invokedAddControllerProviderParametersList = [(controllerProvider: ControllerProvider, priority: Int)]()

    func add(controllerProvider: ControllerProvider, priority: Int) {
        invokedAddControllerProvider = true
        invokedAddControllerProviderCount += 1
        invokedAddControllerProviderParameters = (controllerProvider, priority)
        invokedAddControllerProviderParametersList.append((controllerProvider, priority))
    }

    var invokedAddOptionProvider = false
    var invokedAddOptionProviderCount = 0
    var invokedAddOptionProviderParameters: (optionProvider: RoutingOptionProvider, priority: Int)?
    var invokedAddOptionProviderParametersList = [(optionProvider: RoutingOptionProvider, priority: Int)]()

    func add(optionProvider: RoutingOptionProvider, priority: Int) {
        invokedAddOptionProvider = true
        invokedAddOptionProviderCount += 1
        invokedAddOptionProviderParameters = (optionProvider, priority)
        invokedAddOptionProviderParametersList.append((optionProvider, priority))
    }

    var invokedAddRoutingObserver = false
    var invokedAddRoutingObserverCount = 0
    var invokedAddRoutingObserverParameters: (routingObserver: RoutingObserver, priority: Int, routePattern: String?)?
    var invokedAddRoutingObserverParametersList = [(routingObserver: RoutingObserver, priority: Int, routePattern: String?)]()

    func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?) {
        invokedAddRoutingObserver = true
        invokedAddRoutingObserverCount += 1
        invokedAddRoutingObserverParameters = (routingObserver, priority, routePattern)
        invokedAddRoutingObserverParametersList.append((routingObserver, priority, routePattern))
    }

    var invokedAddRoutingPresenter = false
    var invokedAddRoutingPresenterCount = 0
    var invokedAddRoutingPresenterParameters: (routingPresenter: RoutingPresenter, priority: Int)?
    var invokedAddRoutingPresenterParametersList = [(routingPresenter: RoutingPresenter, priority: Int)]()

    func add(routingPresenter: RoutingPresenter, priority: Int) {
        invokedAddRoutingPresenter = true
        invokedAddRoutingPresenterCount += 1
        invokedAddRoutingPresenterParameters = (routingPresenter, priority)
        invokedAddRoutingPresenterParametersList.append((routingPresenter, priority))
    }
}
