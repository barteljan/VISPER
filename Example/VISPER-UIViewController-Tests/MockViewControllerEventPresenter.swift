//
//  MockViewControllerEventPresenter.swift
//  VISPER-UIViewController-Tests
//
//  Created by bartel on 13.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Presenter

class MockViewControllerEventPresenter: NSObject, ViewControllerEventPresenter {


    var invokedIsResponsibleFor = false
    var invokedIsResponsibleForCount = 0
    var invokedIsResponsibleForParameters: (event: NSObject, view: UIView?, controller: UIViewController)?
    var invokedIsResponsibleForParametersList = [(event: NSObject, view: UIView?, controller: UIViewController)]()
    var stubbedIsResponsibleForResult: Bool! = false

    func isResponsibleFor(event: NSObject, view: UIView?, controller: UIViewController) -> Bool {
        invokedIsResponsibleFor = true
        invokedIsResponsibleForCount += 1
        invokedIsResponsibleForParameters = (event, view, controller)
        invokedIsResponsibleForParametersList.append((event, view, controller))
        return stubbedIsResponsibleForResult
    }

    var invokedReceivedEvent = false
    var invokedReceivedEventCount = 0
    var invokedReceivedEventParameters: (event: NSObject, view: UIView?, controller: UIViewController)?
    var invokedReceivedEventParametersList = [(event: NSObject, view: UIView?, controller: UIViewController)]()

    func receivedEvent(event: NSObject, view: UIView?, controller: UIViewController) {
        invokedReceivedEvent = true
        invokedReceivedEventCount += 1
        invokedReceivedEventParameters = (event, view, controller)
        invokedReceivedEventParametersList.append((event, view, controller))
    }
}
