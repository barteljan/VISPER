//
//  MockPresenterProvider.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 11.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Core

class MockPresenterProvider: NSObject,PresenterProvider {

    var invokedIsResponsible = false
    var invokedIsResponsibleCount = 0
    var invokedIsResponsibleTime : Date?
    var invokedIsResponsibleParameters: (routeResult: RouteResult, controller: UIViewController)?
    var invokedIsResponsibleParametersList = [(routeResult: RouteResult, controller: UIViewController)]()
    var stubbedIsResponsibleResult: Bool! = false

    func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        invokedIsResponsible = true
        invokedIsResponsibleCount += 1
        invokedIsResponsibleTime = Date()
        invokedIsResponsibleParameters = (routeResult, controller)
        invokedIsResponsibleParametersList.append((routeResult, controller))
        return stubbedIsResponsibleResult
    }

    var invokedMakePresenters = false
    var invokedMakePresentersCount = 0
    var invokedMakePresentersParameters: (routeResult: RouteResult, controller: UIViewController)?
    var invokedMakePresentersParametersList = [(routeResult: RouteResult, controller: UIViewController)]()
    var stubbedMakePresentersResult: [Presenter]! = []

    func makePresenters(routeResult: RouteResult, controller: UIViewController) -> [Presenter] {
        invokedMakePresenters = true
        invokedMakePresentersCount += 1
        invokedMakePresentersParameters = (routeResult, controller)
        invokedMakePresentersParametersList.append((routeResult, controller))
        return stubbedMakePresentersResult
    }
}
