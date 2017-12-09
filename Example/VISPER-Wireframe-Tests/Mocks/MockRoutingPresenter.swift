//
//  MockRoutingPresenter.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 19.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import VISPER_Wireframe_Core



class MockRoutingPresenter: NSObject, RoutingPresenter {

    var invokedIsResponsible = false
    var invokedIsResponsibleCount = 0
    var invokedIsResponsibleParameters: (routeResult: RouteResult, Void)?
    var invokedIsResponsibleParametersList = [(routeResult: RouteResult, Void)]()
    var stubbedIsResponsibleResult: Bool! = false
    var invokedIsResponsibleTime : Date?

    func isResponsible(routeResult: RouteResult) -> Bool {
        invokedIsResponsible = true
        invokedIsResponsibleCount += 1
        invokedIsResponsibleTime = Date()
        invokedIsResponsibleParameters = (routeResult, ())
        invokedIsResponsibleParametersList.append((routeResult, ()))
        return stubbedIsResponsibleResult
    }

    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)?
    var invokedPresentParametersList = [(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate)]()

    func present(controller: UIViewController, routeResult: RouteResult, wireframe: Wireframe, delegate: RoutingDelegate, completion: @escaping () -> ()) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (controller, routeResult, wireframe, delegate)
        invokedPresentParametersList.append((controller, routeResult, wireframe, delegate))
        completion()
    }
}
