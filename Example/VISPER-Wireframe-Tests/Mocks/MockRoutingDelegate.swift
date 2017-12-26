//
//  MockRoutingDelegate.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 23.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Core

class MockRoutingDelegate: NSObject, RoutingDelegate {
    
    var invokedSetRoutingObserver = false
    var routingObserver: RoutingObserver? {
        didSet {
            invokedSetRoutingObserver = true
        }
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
