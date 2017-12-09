//
//  MockComposedRoutingPresenter.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 02.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Wireframe
import VISPER_Wireframe_Core

class MockComposedRoutingPresenter: NSObject, ComposedRoutingPresenter {

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (routingPresenter: RoutingPresenter, priority: Int)?
    var invokedAddParametersList = [(routingPresenter: RoutingPresenter, priority: Int)]()

    func add(routingPresenter: RoutingPresenter, priority: Int) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (routingPresenter, priority)
        invokedAddParametersList.append((routingPresenter, priority))
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

    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)?
    var invokedPresentParametersList = [(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)]()
    var invokedPresentParametersCompletion : (() -> Void)?
    func present(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate, completion: @escaping () -> ()) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (controller, routeResult, wireframe, delegate)
        invokedPresentParametersList.append((controller, routeResult, wireframe, delegate))
        invokedPresentParametersCompletion = completion
    }
}
