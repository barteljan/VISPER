//
//  MockRoutingObserver.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 19.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
@testable import VISPER_Wireframe_Core
@testable import VISPER_Wireframe




class MockRoutingObserver: NSObject, RoutingObserver {

    var invokedWillPresent = false
    var invokedWillPresentCount = 0
    var invokedWillPresentParameters: (controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)?
    var invokedWillPresentParametersList = [(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)]()
    var invokedWillPresentTime : Date?

    func willPresent(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe) {
        invokedWillPresent = true
        invokedWillPresentCount += 1
        invokedWillPresentTime = Date()
        invokedWillPresentParameters = (controller, routeResult, routingPresenter, wireframe)
        invokedWillPresentParametersList.append((controller, routeResult, routingPresenter, wireframe))
    }

    var invokedDidPresent = false
    var invokedDidPresentCount = 0
    var invokedDidPresentParameters: (controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)?
    var invokedDidPresentParametersList = [(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)]()
    var invokedDidPresentTime : Date?

    func didPresent(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe) {
        invokedDidPresent = true
        invokedDidPresentCount += 1
        invokedDidPresentTime = Date()
        invokedDidPresentParameters = (controller, routeResult, routingPresenter, wireframe)
        invokedDidPresentParametersList.append((controller, routeResult, routingPresenter, wireframe))
    }
}
