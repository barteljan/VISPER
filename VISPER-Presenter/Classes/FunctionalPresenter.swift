//
//  FunctionalPresenter.swift
//  VISPER-Presenter
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core

open class FunctionalPresenter : Presenter {
    
    public typealias IsResponsibleCallback = (_ routeResult: RouteResult, _ controller: UIViewController) -> Bool
    public typealias AddPresentationLogicCallback = (_ routeResult: RouteResult, _ controller: UIViewController) throws -> Void
    
    public let isResponsibleCallback: IsResponsibleCallback?
    public let addPresentationLogic: AddPresentationLogicCallback?
    
    public init(isResponsibleCallback: IsResponsibleCallback? = nil,
              addPresentationLogic: AddPresentationLogicCallback? = nil){
        self.isResponsibleCallback = isResponsibleCallback
        self.addPresentationLogic = addPresentationLogic
    }
    
    open func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        
        if let callback = self.isResponsibleCallback {
            return callback(routeResult,controller)
        }
        
        return true
    }
    
    open func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        if let callback = self.addPresentationLogic {
            try callback(routeResult, controller)
        }
    }
    
}
