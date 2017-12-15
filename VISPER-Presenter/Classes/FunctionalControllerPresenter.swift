//
//  FunctionalControllerPresenter.swift
//  VISPER-Presenter
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core

open class FunctionalControllerPresenter: ControllerPresenter {
    
    public typealias IsResponsibleCallback = (_ routeResult: RouteResult, _ controller: UIViewController) -> Bool
    public typealias AddPresentationLogicCallback = (_ routeResult: RouteResult, _ controller: UIViewController) throws -> Void
    public typealias LoadViewCallback = (_ view: UIView?, _ controller: UIViewController) -> Void
    public typealias ViewDidLoadCallback = (_ view: UIView, _ controller: UIViewController) -> Void
    public typealias ViewWillAppearCallback = (_ animated: Bool,_ view: UIView, _ controller: UIViewController) -> Void
    public typealias ViewDidAppearCallback = (_ animated: Bool,_ view: UIView, _ controller: UIViewController) -> Void
    public typealias ViewWillDisappearCallback = (_ animated: Bool,_ view: UIView, _ controller: UIViewController) -> Void
    public typealias ViewDidDisappearCallback = (_ animated: Bool,_ view: UIView, _ controller: UIViewController) -> Void
    public typealias WillRouteCallback = (_ wireframe: Wireframe, _ routeResult: RouteResult, _ controller: UIViewController) -> Void
    public typealias DidRouteCallback = (_ wireframe: Wireframe, _ routeResult: RouteResult, _ controller: UIViewController) -> Void
    
    public let isResponsibleCallback: IsResponsibleCallback?
    public let addPresentationLogicCallback: AddPresentationLogicCallback?
    public let loadViewCallback: LoadViewCallback?
    public let viewDidLoadCallback: ViewDidLoadCallback?
    public let viewWillAppearCallback: ViewWillAppearCallback?
    public let viewDidAppearCallback: ViewDidAppearCallback?
    public let viewWillDisappearCallback: ViewWillDisappearCallback?
    public let viewDidDisappearCallback: ViewDidDisappearCallback?
    public let willRouteCallback: WillRouteCallback?
    public let didRouteCallback: DidRouteCallback?
    
    
    public init(isResponsibleCallback: IsResponsibleCallback? = nil,
       addPresentationLogicCallback: AddPresentationLogicCallback? = nil,
                   loadViewCallback: LoadViewCallback? = nil,
                viewDidLoadCallback: ViewDidLoadCallback? = nil,
             viewWillAppearCallback: ViewWillAppearCallback? = nil,
              viewDidAppearCallback: ViewDidAppearCallback? = nil,
          viewWillDisappearCallback: ViewWillDisappearCallback? = nil,
           viewDidDisappearCallback: ViewDidDisappearCallback? = nil,
                  willRouteCallback: WillRouteCallback? = nil,
                   didRouteCallback: DidRouteCallback? = nil
        ) {
        
        self.isResponsibleCallback = isResponsibleCallback
        self.addPresentationLogicCallback = addPresentationLogicCallback
        self.loadViewCallback = loadViewCallback
        self.viewDidLoadCallback = viewDidLoadCallback
        self.viewWillAppearCallback = viewWillAppearCallback
        self.viewDidAppearCallback = viewDidAppearCallback
        self.viewWillDisappearCallback = viewWillDisappearCallback
        self.viewDidDisappearCallback = viewDidDisappearCallback
        self.willRouteCallback = willRouteCallback
        self.didRouteCallback = didRouteCallback
        
    }
    
    open func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        if let callback = self.isResponsibleCallback {
            return callback(routeResult,controller)
        }
        return true
    }
    
    open func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        if let callback = self.addPresentationLogicCallback {
            try callback(routeResult, controller)
        }
        controller.add(controllerPresenter: self)
    }
    
    open func load(view: UIView?, controller: UIViewController) {
        if let callback = self.loadViewCallback {
            callback(view, controller)
        }
    }
    
    open func viewDidLoad(view: UIView, controller: UIViewController)  {
        if let callback = self.viewDidLoadCallback {
            callback(view,controller)
        }
    }
    
    open func viewWillAppear(animated: Bool, view: UIView, controller: UIViewController) {
        if let callback = self.viewWillAppearCallback {
            callback(animated, view, controller)
        }
    }
    
    open func viewDidAppear(animated: Bool, view: UIView, controller: UIViewController) {
        if let callback = self.viewDidAppearCallback {
            callback(animated, view, controller)
        }
    }
    
    open func viewWillDisappear(animated: Bool, view: UIView, controller: UIViewController) {
        if let callback = self.viewWillDisappearCallback {
            callback(animated, view, controller)
        }
    }
    
    open func viewDidDisappear(animated: Bool, view: UIView, controller: UIViewController) {
        if let callback = self.viewDidDisappearCallback {
            callback(animated, view, controller)
        }
    }
    
    open func willRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController) {
        if let callback = self.willRouteCallback {
            callback(wireframe, routeResult, controller)
        }
    }
    
    open func didRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController) {
        if let callback = self.didRouteCallback {
            callback(wireframe, routeResult, controller)
        }
    }
    
}
