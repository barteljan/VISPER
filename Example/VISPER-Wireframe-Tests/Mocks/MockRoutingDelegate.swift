//
//  MockRoutingDelegate.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 23.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Wireframe_Core

class MockRoutingDelegate: NSObject, RoutingDelegate {


    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (routingObserver: RoutingObserver, priority: Int, routePattern: String?)?
    var invokedAddParametersList = [(routingObserver: RoutingObserver, priority: Int, routePattern: String?)]()

    func add(routingObserver: RoutingObserver, priority: Int, routePattern: String?) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (routingObserver, priority, routePattern)
        invokedAddParametersList.append((routingObserver, priority, routePattern))
    }

    var invokedWillPresent = false
    var invokedWillPresentCount = 0
    var invokedWillPresentParameters: (controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)?
    var invokedWillPresentParametersList = [(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)]()

    func willPresent(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe) {
        invokedWillPresent = true
        invokedWillPresentCount += 1
        invokedWillPresentParameters = (controller, routeResult, routingPresenter, wireframe)
        invokedWillPresentParametersList.append((controller, routeResult, routingPresenter, wireframe))
    }

    var invokedDidPresent = false
    var invokedDidPresentCount = 0
    var invokedDidPresentParameters: (controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)?
    var invokedDidPresentParametersList = [(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe)]()

    func didPresent(controller: UIViewController, routeResult: RouteResult, routingPresenter: RoutingPresenter?, wireframe: Wireframe) {
        invokedDidPresent = true
        invokedDidPresentCount += 1
        invokedDidPresentParameters = (controller, routeResult, routingPresenter, wireframe)
        invokedDidPresentParametersList.append((controller, routeResult, routingPresenter, wireframe))
    }
}
