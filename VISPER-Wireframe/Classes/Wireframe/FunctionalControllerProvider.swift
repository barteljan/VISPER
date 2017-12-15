//
//  FunctionalControllerPresenter.swift
//  VISPER-Presenter
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core

open class FunctionalControllerProvider: ControllerProvider {
    
    public typealias IsResponsibleCallback = (_ routeResult: RouteResult) -> Bool
    public typealias MakeControllerCallback = (_ routeResult: RouteResult) throws -> UIViewController
    
    public let isResponsibleCallback: IsResponsibleCallback
    public let makeControllerCallback: MakeControllerCallback
    
    public init(isResponsibleCallback: @escaping IsResponsibleCallback,
               makeControllerCallback: @escaping MakeControllerCallback){
        self.isResponsibleCallback = isResponsibleCallback
        self.makeControllerCallback = makeControllerCallback
    }
    
    open func isResponsible(routeResult: RouteResult) -> Bool {
        return self.isResponsibleCallback(routeResult)
    }
    
    open func makeController(routeResult: RouteResult) throws -> UIViewController {
        return try self.makeControllerCallback(routeResult)
    }
    
}

