//
// Created by bartel on 19.11.17.
// Copyright (c) 2017 CocoaPods. All rights reserved.
//

import Foundation
@testable import VISPER_Wireframe_Core
@testable import VISPER_Wireframe



class MockControllerProvider: NSObject, ControllerProvider {

    var invokedIsResponsible = false
    var invokedIsResponsibleCount = 0
    var invokedIsResponsibleParameters: (routeResult: RouteResult, Void)?
    var invokedIsResponsibleParametersList = [(routeResult: RouteResult, Void)]()
    var stubbedIsResponsibleResult: Bool! = false
    var invokedIsResponsibleTime: Date?

    func isResponsible(routeResult: RouteResult) -> Bool {
        invokedIsResponsible = true
        invokedIsResponsibleTime = Date()
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

