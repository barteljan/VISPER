//
//  MockComposedControllerProvider.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 02.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Wireframe_Core
import VISPER_Wireframe

class MockComposedControllerProvider: NSObject, ComposedControllerProvider {

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

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (controllerProvider: ControllerProvider, priority: Int)?
    var invokedAddParametersList = [(controllerProvider: ControllerProvider, priority: Int)]()

    func add(controllerProvider: ControllerProvider, priority: Int) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (controllerProvider, priority)
        invokedAddParametersList.append((controllerProvider, priority))
    }

    var invokedIsResponsible = false
    var invokedIsResponsibleCount = 0
    var invokedIsResponsibleParameters: (routeResult: RouteResult, Void)?
    var invokedIsResponsibleParametersList = [(routeResult: RouteResult, Void)]()
    var stubbedIsResponsibleResult: Bool! = false

    func isResponsible(routeResult: RouteResult) -> Bool {
        invokedIsResponsible = true
        invokedIsResponsibleCount += 1
        invokedIsResponsibleParameters = (routeResult, ())
        invokedIsResponsibleParametersList.append((routeResult, ()))
        return stubbedIsResponsibleResult
    }

    var invokedMakeController = false
    var invokedMakeControllerCount = 0
    var invokedMakeControllerParameters: (routeResult: RouteResult, Void)?
    var invokedMakeControllerParametersList = [(routeResult: RouteResult, Void)]()
    var stubbedMakeControllerResult: UIViewController!

    func makeController(routeResult: RouteResult) -> UIViewController {
        invokedMakeController = true
        invokedMakeControllerCount += 1
        invokedMakeControllerParameters = (routeResult, ())
        invokedMakeControllerParametersList.append((routeResult, ()))
        return stubbedMakeControllerResult
    }
}
