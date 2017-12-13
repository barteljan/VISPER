//
//  ControllerPresenter.swift
//  VISPER-Core
//
//  Created by bartel on 13.12.17.
//

import Foundation
import UIKit

public protocol ControllerPresenter: Presenter{
    
    func load(view: UIView?, controller: UIViewController)
    
    func viewDidLoad(view: UIView, controller: UIViewController)
    
    func viewWillAppear(animated: Bool, view: UIView, controller: UIViewController)
    
    func viewDidAppear(animated: Bool, view: UIView, controller: UIViewController)
    
    func viewWillDisappear(animated: Bool, view: UIView, controller: UIViewController)
    
    func viewDidDisappear(animated: Bool, view: UIView, controller: UIViewController)
    
    func willRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController)
    
    func didRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController)
    
}

public extension ControllerPresenter {
    
    public func load(view: UIView?, controller: UIViewController){}
    
    public func viewDidLoad(view: UIView, controller: UIViewController){}
    
    public func viewWillAppear(animated: Bool, view: UIView, controller: UIViewController){}
    
    public func viewDidAppear(animated: Bool, view: UIView, controller: UIViewController){}
    
    public func viewWillDisappear(animated: Bool, view: UIView, controller: UIViewController){}
    
    public func viewDidDisappear(animated: Bool, view: UIView, controller: UIViewController){}
    
    public func willRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController){}
    
    public func didRoute(wireframe: Wireframe, routeResult: RouteResult, controller: UIViewController){}

}
