//
//  MockPresenter.swift
//  VISPER-Wireframe-Tests
//
//  Created by bartel on 11.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Core

class MockPresenter: NSObject,Presenter {
    
    var stubbedIsResponsibleResult = false
    func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        return stubbedIsResponsibleResult
    }
    

    var invokedAddPresentationLogic = false
    var invokedAddPresentationLogicCount = 0
    var invokedAddPresentationLogicParameters: (routeResult: RouteResult, controller: UIViewController)?
    var invokedAddPresentationLogicParametersList = [(routeResult: RouteResult, controller: UIViewController)]()

    func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) {
        invokedAddPresentationLogic = true
        invokedAddPresentationLogicCount += 1
        invokedAddPresentationLogicParameters = (routeResult, controller)
        invokedAddPresentationLogicParametersList.append((routeResult, controller))
    }
}
