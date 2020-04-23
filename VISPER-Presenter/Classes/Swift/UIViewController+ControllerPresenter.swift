//
//  UIViewController+ControllerPresenter.swift
//  VISPER-UIViewController
//
//  Created by bartel on 14.12.17.
//

import Foundation
import VISPER_Core

public extension UIViewController {
    
    func add(controllerPresenter: ControllerPresenter, priority: Int) {
        let presenter = ControllerPresenterWrapper(presenter: controllerPresenter);
        let wrapper = VISPERPresenterWrapper(presenter: presenter, priority: priority)
        self.addVisperPresenter(wrapper, priority: priority)
    }
    
    func add(controllerPresenter: ControllerPresenter){
        self.add(controllerPresenter: controllerPresenter, priority: 0)
    }
}

public extension ControllerPresenter {
    
    func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        controller.add(controllerPresenter: self)
    }
    
}
