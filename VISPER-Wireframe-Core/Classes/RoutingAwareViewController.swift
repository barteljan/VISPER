//
//  RoutingAwareViewController.swift
//  VISPER-Wireframe
//
//  Created by bartel on 19.11.17.
//

import Foundation

public protocol RoutingAwareViewController {
    
    func willRoute(wireframe: Wireframe, routeResult: RouteResult)
    
    func didRoute(wireframe: Wireframe, routeResult: RouteResult)
    
}

public extension RoutingAwareViewController {
    
    func willRoute(wireframe: Wireframe, routeResult: RouteResult){}
    
    func didRoute(wireframe: Wireframe, routeResult: RouteResult){}
    
}
