//
//  MockViewController.swift
//  VISPER-Wireframe_Example
//
//  Created by Jan Bartel on 20.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Wireframe_UIViewController

class MockViewController : UIViewController {
    
    var invokedWillRoute = false
    var invokedWillRouteTime : Date?
    var invokedWillRouteParameters : (wireframe: WireframeObjc,routeResult: RouteResultObjc)?
    override func willRoute(_ wireframe: WireframeObjc!, routeResult: RouteResultObjc) {
        super.willRoute(wireframe, routeResult: routeResult)
        invokedWillRoute = true
        invokedWillRouteTime = Date()
        invokedWillRouteParameters = (wireframe: wireframe,routeResult: routeResult)
    }
    
    var invokedDidRoute = false
    var invokedDidRouteTime : Date?
    var invokedDidRouteParameters : (wireframe: WireframeObjc,routeResult: RouteResultObjc)?
    override func didRoute(_ wireframe: WireframeObjc, routeResult: RouteResultObjc) {
        super.didRoute(wireframe, routeResult: routeResult)
        invokedDidRoute = true
        invokedDidRouteTime = Date()
        invokedDidRouteParameters = (wireframe: wireframe,routeResult: routeResult)
    }
    
}
