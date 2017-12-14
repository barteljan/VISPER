//
//  UIViewController+ControllerPresenter.swift
//  VISPER-UIViewController
//
//  Created by bartel on 14.12.17.
//

import Foundation
import VISPER_Core
import VISPER_Objc

public extension UIViewController {
    
    public func add(controllerPresenter: ControllerPresenter, priority: Int) {
        let presenter = ControllerPresenterObjc(presenter: controllerPresenter)
        self.addVisperPresenter(presenter, priority: priority)
    }
    
    public func add(controllerPresenter: ControllerPresenter){
        self.add(controllerPresenter: controllerPresenter, priority: 0)
    }
}

public extension ControllerPresenter {
    
    public func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        controller.add(controllerPresenter: self)
    }
    
}
