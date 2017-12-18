//
//  UIViewController+ControllerPresenter.swift
//  VISPER-UIViewController
//
//  Created by bartel on 14.12.17.
//

import Foundation
import VISPER_Core

public extension UIViewController {
    
    public func add(controllerPresenter: ControllerPresenter, priority: Int) {
        let presenter = ControllerPresenterWrapper(presenter: controllerPresenter);
        let wrapper = VISPERPresenterWrapper(presenter: presenter, priority: priority)
        self.addVisperPresenter(wrapper, priority: priority)
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
