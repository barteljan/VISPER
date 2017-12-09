//
//  MockRouter.swift
//  VISPER-Wireframe_Example
//
//  Created by bartel on 19.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
@testable import VISPER_Wireframe_Core
@testable import VISPER_Wireframe

class MockRouter: NSObject, Router {

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (routePattern: String, Void)?
    var invokedAddParametersList = [(routePattern: String, Void)]()

    func add(routePattern: String) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (routePattern, ())
        invokedAddParametersList.append((routePattern, ()))
    }

    var invokedRouteUrlRoutingOptionParameters = false
    var invokedRouteUrlRoutingOptionParametersCount = 0
    var invokedRouteUrlRoutingOptionParametersParameters: (url: URL, parameters: [String: Any]?, routingOption: RoutingOption?)?
    var invokedRouteUrlRoutingOptionParametersParametersList = [(url: URL, parameters: [String: Any]?, routingOption: RoutingOption?)]()
    var stubbedRouteUrlRoutingOptionParametersResult: RouteResult?

    func route(url: URL, parameters: [String: Any]?, routingOption: RoutingOption?) -> RouteResult? {
        invokedRouteUrlRoutingOptionParameters = true
        invokedRouteUrlRoutingOptionParametersCount += 1
        invokedRouteUrlRoutingOptionParametersParameters = (url, parameters, routingOption)
        invokedRouteUrlRoutingOptionParametersParametersList.append((url, parameters, routingOption))
        return stubbedRouteUrlRoutingOptionParametersResult
    }

    var invokedRouteUrl = false
    var invokedRouteUrlCount = 0
    var invokedRouteUrlParameters: (url: URL, parameters: [String: Any]?)?
    var invokedRouteUrlParametersList = [(url: URL, parameters: [String: Any]?)]()
    var stubbedRouteUrlResult: RouteResult!

    func route(url: URL, parameters: [String: Any]?) -> RouteResult? {
        invokedRouteUrl = true
        invokedRouteUrlCount += 1
        invokedRouteUrlParameters = (url, parameters)
        invokedRouteUrlParametersList.append((url, parameters))
        return stubbedRouteUrlResult
    }

    var invokedRoute = false
    var invokedRouteCount = 0
    var invokedRouteParameters: (url: URL, Void)?
    var invokedRouteParametersList = [(url: URL, Void)]()
    var stubbedRouteResult: RouteResult!

    func route(url: URL) -> RouteResult? {
        invokedRoute = true
        invokedRouteCount += 1
        invokedRouteParameters = (url, ())
        invokedRouteParametersList.append((url, ()))
        return stubbedRouteResult
    }
}
