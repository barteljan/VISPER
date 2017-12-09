//
//  MockRoutingOptionProvider.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 19.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
@testable import VISPER_Wireframe_Core
@testable import VISPER_Wireframe



class MockRoutingOptionProvider: NSObject, RoutingOptionProvider {

    var invokedOption = false
    var invokedOptionCount = 0
    var invokedOptionParameters: (routeResult: RouteResult, Void)?
    var invokedOptionParametersList = [(routeResult: RouteResult, Void)]()
    var stubbedOptionResult: RoutingOption!
    var invokedOptionTime : Date?

    func option(routeResult: RouteResult) -> RoutingOption? {
        invokedOption = true
        invokedOptionCount += 1
        invokedOptionTime = Date()
        invokedOptionParameters = (routeResult, ())
        invokedOptionParametersList.append((routeResult, ()))
        return stubbedOptionResult
    }
}

