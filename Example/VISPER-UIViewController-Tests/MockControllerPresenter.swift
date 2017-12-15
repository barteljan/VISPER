//
//  TestControllerPresenter.swift
//  VISPER-UIViewController-Tests
//
//  Created by bartel on 15.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Presenter
import VISPER_Core

enum LifecycleEventString : String {
    case load
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
}

class MockControllerPresenter: ControllerPresenter {

    
    var events = [LifecycleEventString]()
    
    var invokedLoad = false
    var invokedLoadCount = 0
    var invokedLoadParameters: (view: UIView?, controller: UIViewController)?
    var invokedLoadParametersList = [(view: UIView?, controller: UIViewController)]()

    func load(view: UIView?, controller: UIViewController) {
        invokedLoad = true
        invokedLoadCount += 1
        invokedLoadParameters = (view, controller)
        invokedLoadParametersList.append((view, controller))
        events.append(.load)
    }

    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0
    var invokedViewDidLoadParameters: (view: UIView, controller: UIViewController)?
    var invokedViewDidLoadParametersList = [(view: UIView, controller: UIViewController)]()

    func viewDidLoad(view: UIView, controller: UIViewController) {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
        invokedViewDidLoadParameters = (view, controller)
        invokedViewDidLoadParametersList.append((view, controller))
        events.append(.viewDidLoad)
    }

    var invokedViewWillAppear = false
    var invokedViewWillAppearCount = 0
    var invokedViewWillAppearParameters: (animated: Bool, view: UIView, controller: UIViewController)?
    var invokedViewWillAppearParametersList = [(animated: Bool, view: UIView, controller: UIViewController)]()

    func viewWillAppear(animated: Bool, view: UIView, controller: UIViewController) {
        invokedViewWillAppear = true
        invokedViewWillAppearCount += 1
        invokedViewWillAppearParameters = (animated, view, controller)
        invokedViewWillAppearParametersList.append((animated, view, controller))
        events.append(.viewWillAppear)
    }

    var invokedViewDidAppear = false
    var invokedViewDidAppearCount = 0
    var invokedViewDidAppearParameters: (animated: Bool, view: UIView, controller: UIViewController)?
    var invokedViewDidAppearParametersList = [(animated: Bool, view: UIView, controller: UIViewController)]()

    func viewDidAppear(animated: Bool, view: UIView, controller: UIViewController) {
        invokedViewDidAppear = true
        invokedViewDidAppearCount += 1
        invokedViewDidAppearParameters = (animated, view, controller)
        invokedViewDidAppearParametersList.append((animated, view, controller))
        events.append(.viewDidAppear)
    }

    var invokedViewWillDisappear = false
    var invokedViewWillDisappearCount = 0
    var invokedViewWillDisappearParameters: (animated: Bool, view: UIView, controller: UIViewController)?
    var invokedViewWillDisappearParametersList = [(animated: Bool, view: UIView, controller: UIViewController)]()

    func viewWillDisappear(animated: Bool, view: UIView, controller: UIViewController) {
        invokedViewWillDisappear = true
        invokedViewWillDisappearCount += 1
        invokedViewWillDisappearParameters = (animated, view, controller)
        invokedViewWillDisappearParametersList.append((animated, view, controller))
        events.append(.viewWillDisappear)
    }

    var invokedViewDidDisappear = false
    var invokedViewDidDisappearCount = 0
    var invokedViewDidDisappearParameters: (animated: Bool, view: UIView, controller: UIViewController)?
    var invokedViewDidDisappearParametersList = [(animated: Bool, view: UIView, controller: UIViewController)]()

    func viewDidDisappear(animated: Bool, view: UIView, controller: UIViewController) {
        invokedViewDidDisappear = true
        invokedViewDidDisappearCount += 1
        invokedViewDidDisappearParameters = (animated, view, controller)
        invokedViewDidDisappearParametersList.append((animated, view, controller))
        events.append(.viewDidDisappear)
    }

    var invokedWillRoute = false
    var invokedWillRouteCount = 0
    var invokedWillRouteParameters: (wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController)?
    var invokedWillRouteParametersList = [(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController)]()

    func willRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController) {
        invokedWillRoute = true
        invokedWillRouteCount += 1
        invokedWillRouteParameters = (wireframe, routeResult, controller)
        invokedWillRouteParametersList.append((wireframe, routeResult, controller))
    }

    var invokedDidRoute = false
    var invokedDidRouteCount = 0
    var invokedDidRouteParameters: (wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController)?
    var invokedDidRouteParametersList = [(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController)]()

    func didRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController) {
        invokedDidRoute = true
        invokedDidRouteCount += 1
        invokedDidRouteParameters = (wireframe, routeResult, controller)
        invokedDidRouteParametersList.append((wireframe, routeResult, controller))
    }

    var invokedIsResponsible = false
    var invokedIsResponsibleCount = 0
    var invokedIsResponsibleParameters: (routeResult: RouteResult, controller: UIViewController)?
    var invokedIsResponsibleParametersList = [(routeResult: RouteResult, controller: UIViewController)]()
    var stubbedIsResponsibleResult: Bool! = false

    func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        invokedIsResponsible = true
        invokedIsResponsibleCount += 1
        invokedIsResponsibleParameters = (routeResult, controller)
        invokedIsResponsibleParametersList.append((routeResult, controller))
        return stubbedIsResponsibleResult
    }

}
