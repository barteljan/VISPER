//
//  MockRoutingAwareViewController.swift
//  VISPER-Wireframe_Example
//
//  Created by bartel on 02.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import VISPER_Wireframe_Core

class MockRoutingAwareViewController: UIViewController, RoutingAwareViewController {

    var invokedWillRoute = false
    var invokedWillRouteCount = 0
    var invokedWillRouteParameters: (wireframe: Wireframe, routeResult: RouteResult)?
    var invokedWillRouteParametersList = [(wireframe: Wireframe, routeResult: RouteResult)]()

    func willRoute(wireframe: Wireframe, routeResult: RouteResult) {
        invokedWillRoute = true
        invokedWillRouteCount += 1
        invokedWillRouteParameters = (wireframe, routeResult)
        invokedWillRouteParametersList.append((wireframe, routeResult))
    }

    var invokedDidRoute = false
    var invokedDidRouteCount = 0
    var invokedDidRouteParameters: (wireframe: Wireframe, routeResult: RouteResult)?
    var invokedDidRouteParametersList = [(wireframe: Wireframe, routeResult: RouteResult)]()

    func didRoute(wireframe: Wireframe, routeResult: RouteResult) {
        invokedDidRoute = true
        invokedDidRouteCount += 1
        invokedDidRouteParameters = (wireframe, routeResult)
        invokedDidRouteParametersList.append((wireframe, routeResult))
    }
}
