//
//  MockTopControllerProvider.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 26.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Core

class MockTopControllerResolver: NSObject, TopControllerResolver {

    var invokedIsResponsible = false
    var invokedIsResponsibleCount = 0
    var invokedIsResponsibleParameters: (controller: UIViewController, Void)?
    var invokedIsResponsibleParametersList = [(controller: UIViewController, Void)]()
    var stubbedIsResponsibleResult: Bool! = false

    func isResponsible(controller: UIViewController) -> Bool {
        invokedIsResponsible = true
        invokedIsResponsibleCount += 1
        invokedIsResponsibleParameters = (controller, ())
        invokedIsResponsibleParametersList.append((controller, ()))
        return stubbedIsResponsibleResult
    }

    var invokedTopController = false
    var invokedTopControllerCount = 0
    var invokedTopControllerParameters: (controller: UIViewController, Void)?
    var invokedTopControllerParametersList = [(controller: UIViewController, Void)]()
    var stubbedTopControllerResult: UIViewController!

    func topController(of controller: UIViewController) -> UIViewController {
        invokedTopController = true
        invokedTopControllerCount += 1
        invokedTopControllerParameters = (controller, ())
        invokedTopControllerParametersList.append((controller, ()))
        return stubbedTopControllerResult
    }
}
