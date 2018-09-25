//
//  ControllerPresenterObjc.swift
//  VISPER-Objc
//
//  Created by bartel on 14.12.17.
//

import Foundation
import VISPER_Presenter
import VISPER_Core

@objc open class ControllerPresenterObjc : ViewControllerLifecycleEventPresenter {
    
    public let presenter: ControllerPresenter
    
    public init(presenter: ControllerPresenter){
        self.presenter = presenter
    }
    
    open override func isResponsible(routeResult: RouteResult,
                                     controller: UIViewController) -> Bool {
        return self.presenter.isResponsible(routeResult:routeResult,controller:controller)
    }
    
    open func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        try self.presenter.addPresentationLogic(routeResult: routeResult, controller: controller)
    }
    
    @objc override open func load(view: UIView?, controller: UIViewController) {
        self.presenter.load(view: view, controller: controller)
    }
    
    @objc override open func viewDidLoad(view: UIView, controller: UIViewController) {
        self.presenter.viewDidLoad(view:view, controller: controller)
    }
    
    @objc override open func viewWillAppear(animated: Bool, view: UIView, controller: UIViewController) {
        self.presenter.viewWillAppear(animated:animated, view: view, controller: controller)
    }
    
    @objc override open func viewDidAppear(animated: Bool, view: UIView, controller: UIViewController) {
       self.presenter.viewDidAppear(animated: animated, view: view, controller: controller)
    }
    
    @objc override open func viewWillDisappear(animated: Bool, view: UIView, controller: UIViewController) {
       self.presenter.viewWillDisappear(animated: animated, view: view, controller: controller)
    }
    
    @objc override open func viewDidDisappear(animated: Bool, view: UIView, controller: UIViewController) {
        self.presenter.viewDidDisappear(animated: animated, view: view, controller: controller)
    }
    
    
}
