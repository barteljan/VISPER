//
//  ViewControllerLifecycleEventPresenter.swift
//  VISPER-Presenter
//
//  Created by bartel on 13.12.17.
//

import Foundation
import UIKit
import VISPER_Core

@objc open class ViewControllerLifecycleEventPresenter: NSObject, ViewControllerEventPresenter,ControllerPresenter{
    
    open func addPresentationLogic(routeResult: RouteResult, controller: UIViewController) throws {
        
    }
    
    @objc open func isResponsibleFor(event: NSObject,view: UIView?,controller: UIViewController) -> Bool{
        return true
    }
    
    @objc open func receivedEvent(event: NSObject, view: UIView?, controller: UIViewController) {
        
        if event is LoadViewEvent {
            self.load(view:view, controller: controller)
        }
        
        if let view = view {
            if event is ViewDidLoadEvent {
                self.viewDidLoad(view:view, controller: controller)
            } else if let event = event as? ViewWillAppearEvent {
                self.viewWillAppear(animated:event.animated, view: view, controller: controller)
            } else if let event = event as? ViewDidAppearEvent {
                self.viewDidAppear(animated:event.animated, view: view, controller: controller)
            } else if let event = event as? ViewWillDisappearEvent {
                self.viewWillDisappear(animated:event.animated, view: view, controller: controller)
            } else if let event = event as? ViewDidDisappearEvent {
                self.viewDidDisappear(animated:event.animated, view: view, controller: controller)
            }
        }
    }
    
    @objc open func load(view: UIView?, controller: UIViewController) {
    
    }
    
    @objc open func viewDidLoad(view: UIView, controller: UIViewController) {
        
    }
    
    @objc open func viewWillAppear(animated: Bool, view: UIView, controller: UIViewController) {
        
    }
    
    @objc open func viewDidAppear(animated: Bool, view: UIView, controller: UIViewController) {
        
    }
    
    @objc open func viewWillDisappear(animated: Bool, view: UIView, controller: UIViewController) {
       
    }
    
    @objc open func viewDidDisappear(animated: Bool, view: UIView, controller: UIViewController) {
      
    }
}



