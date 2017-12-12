//
//  MockComposedPresenterProvider.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 12.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Wireframe
import VISPER_Core

public class MockComposedPresenterProvider: ComposedPresenterProvider {

    public var invokedAdd = false
    public var invokedAddCount = 0
    public var invokedAddParameters: (provider: PresenterProvider, priority: Int)?
    public var invokedAddParametersList = [(provider: PresenterProvider, priority: Int)]()

    public func add(provider: PresenterProvider, priority: Int) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (provider, priority)
        invokedAddParametersList.append((provider, priority))
    }

    public var invokedIsResponsible = false
    public var invokedIsResponsibleCount = 0
    public var invokedIsResponsibleParameters: (routeResult: RouteResult, controller: UIViewController)?
    public var invokedIsResponsibleParametersList = [(routeResult: RouteResult, controller: UIViewController)]()
    public var stubbedIsResponsibleResult: Bool! = false

    public func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        invokedIsResponsible = true
        invokedIsResponsibleCount += 1
        invokedIsResponsibleParameters = (routeResult, controller)
        invokedIsResponsibleParametersList.append((routeResult, controller))
        return stubbedIsResponsibleResult
    }

    public var invokedMakePresenters = false
    public var invokedMakePresentersCount = 0
    public var invokedMakePresentersParameters: (routeResult: RouteResult, controller: UIViewController)?
    public var invokedMakePresentersParametersList = [(routeResult: RouteResult, controller: UIViewController)]()
    public var stubbedMakePresentersResult: [Presenter]! = []

    public func makePresenters(routeResult: RouteResult, controller: UIViewController) -> [Presenter] {
        invokedMakePresenters = true
        invokedMakePresentersCount += 1
        invokedMakePresentersParameters = (routeResult, controller)
        invokedMakePresentersParametersList.append((routeResult, controller))
        return stubbedMakePresentersResult
    }
}
