//
//  Presenter.swift
//  VISPER-Swift
//
//  Created by bartel on 11.12.17.
//

import Foundation

public protocol Presenter {
    
    
    func isResponsible(routeResult: RouteResult,
                       controller: UIViewController) -> Bool
    
    /// Add presentation logic to a controller
    ///
    /// - Parameters:
    ///   - routeResult: the route result with which the controller is presented
    ///   - controller: the controller
    func addPresentationLogic( routeResult: RouteResult,
                                controller: UIViewController) throws
    
}
