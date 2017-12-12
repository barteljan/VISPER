//
//  PresenterProvider.swift
//  VISPER-Core
//
//  Created by bartel on 11.12.17.
//

import Foundation

public protocol PresenterProvider {
    
    /// Checks if a PresenterProvider can provide a presenter for a controller
    ///
    /// - Parameters:
    ///   - routeResult: The route result for which a presenter is searched
    ///   - controller: The controller for which a presenter should be provided
    /// - Returns: true if it can create a controller, false otherwise
    func isResponsible( routeResult: RouteResult, controller: UIViewController) -> Bool
    
    
    /// Creates all presenters for a specific RouteResult controller combinations
    ///
    /// - Parameters:
    ///   - routeResult: The route result for which a presenter is searched
    ///   - controller: The controller for which a presenter should be provided
    /// - Returns: An array of presenters
    func makePresenters( routeResult: RouteResult, controller: UIViewController) throws -> [Presenter]
}
