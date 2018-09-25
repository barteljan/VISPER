//
//  ControllerPresenterWrapper.swift
//  VISPER-Presenter
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core



@objc class VISPERPresenterWrapper : NSObject, ViewControllerEventPresenter {
   
    @objc let presenter: ViewControllerLifecycleEventPresenter
    @objc let priority: NSInteger
    
    init(presenter: ViewControllerLifecycleEventPresenter, priority: NSInteger){
        self.presenter = presenter
        self.priority = priority
    }
    
    @objc func isResponsible(_ event: NSObject!, view: UIView!, controller: UIViewController!) -> Bool {
        return self.presenter.isResponsible(event,view:view,controller:controller)
    }
    
    @objc func receivedEvent(_ event: NSObject!, view: UIView!, controller: UIViewController!) {
        self.presenter.receivedEvent(event, view: view, controller: controller)
    }
    
}


@objc class ControllerPresenterWrapper : ViewControllerLifecycleEventPresenter {
    
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
