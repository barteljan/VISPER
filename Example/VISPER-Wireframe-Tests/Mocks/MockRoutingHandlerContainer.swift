//
//  MockRoutingHandlerContainer.swift
//  VISPER-Wireframe_Example
//
//  Created by bartel on 02.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Wireframe
import VISPER_Wireframe_Core

class MockRoutingHandlerContainer: NSObject, RoutingHandlerContainer {

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (priority: Int, Void)?
    var invokedAddResponsibleForParam: ((_ routeResult: RouteResult) -> Bool)?
    var invokedAddHandlerParam: ((_ routeResult: RouteResult) -> Void)?
    var invokedAddParametersList = [(priority: Int, Void)]()
    var stubbedAddResponsibleForResult: (RouteResult, Void)?
    var stubbedAddHandlerResult: (RouteResult, Void)?

    func add(priority: Int, responsibleFor: @escaping (_ routeResult: RouteResult) -> Bool, handler: @escaping RoutingHandler) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddResponsibleForParam = responsibleFor
        invokedAddHandlerParam = handler
        invokedAddParameters = (priority, ())
        invokedAddParametersList.append((priority, ()))
    }

    var invokedPriorityOfHighestResponsibleProvider = false
    var invokedPriorityOfHighestResponsibleProviderCount = 0
    var invokedPriorityOfHighestResponsibleProviderParameters: (routeResult: RouteResult, Void)?
    var invokedPriorityOfHighestResponsibleProviderParametersList = [(routeResult: RouteResult, Void)]()
    var stubbedPriorityOfHighestResponsibleProviderResult: Int!

    func priorityOfHighestResponsibleProvider(routeResult: RouteResult) -> Int? {
        invokedPriorityOfHighestResponsibleProvider = true
        invokedPriorityOfHighestResponsibleProviderCount += 1
        invokedPriorityOfHighestResponsibleProviderParameters = (routeResult, ())
        invokedPriorityOfHighestResponsibleProviderParametersList.append((routeResult, ()))
        return stubbedPriorityOfHighestResponsibleProviderResult
    }

    var invokedHandler = false
    var invokedHandlerCount = 0
    var invokedHandlerParameters: (routeResult: RouteResult, Void)?
    var invokedHandlerParametersList = [(routeResult: RouteResult, Void)]()
    var stubbedHandlerResult: (RoutingHandler)!

    func handler(routeResult: RouteResult) -> RoutingHandler? {
        invokedHandler = true
        invokedHandlerCount += 1
        invokedHandlerParameters = (routeResult, ())
        invokedHandlerParametersList.append((routeResult, ()))
        return stubbedHandlerResult
    }
}
