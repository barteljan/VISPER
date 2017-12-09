//
//  RoutingAwareViewControllerObjc.swift
//  VISPER-Wireframe-Objc
//
//  Created by bartel on 08.12.17.
//

import Foundation


@objc public protocol RoutingAwareViewControllerObjc{
    func willRoute(wireframe: WireframeObjc, routeResult: RouteResultObjc)
    func didRoute(wireframe: WireframeObjc, routeResult: RouteResultObjc)
}

public extension RoutingAwareViewControllerObjc {
    func willRoute(wireframe: WireframeObjc, routeResult: RouteResultObjc) {}
    func didRoute(wireframe: WireframeObjc, routeResult: RouteResultObjc) {}
}

