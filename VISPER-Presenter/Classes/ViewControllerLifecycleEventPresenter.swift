//
//  ViewControllerLifecycleEventPresenter.swift
//  VISPER-Presenter
//
//  Created by bartel on 13.12.17.
//

import Foundation
import UIKit
import VISPER_Objc

open class ViewControllerLifecycleEventPresenter: NSObject, ViewControllerEventPresenter{
    
    @objc open func isResponsibleFor(event: NSObject,view: UIView?,controller: UIViewController) -> Bool{
        return true
    }
    
    @objc open func receivedEvent(event: NSObject, view: UIView?, controller: UIViewController) {
        
        if let event = event as? LoadViewEvent {
            self.load(view, with: controller, event: event)
        } else if let event = event as? ViewDidLoadEvent {
            self.viewDidLoad(view, with: controller, event: event)
        } else if let event = event as? ViewWillAppearEvent {
            self.viewWillAppear(event.animated, view: view, with: controller, on: event)
        } else if let event = event as? ViewDidAppearEvent {
            self.viewDidAppear(event.animated, view: view, with: controller, on: event)
        } else if let event = event as? ViewWillDisappearEvent {
            self.viewWillDisappear(event.animated, view: view, with: controller, on: event)
        } else if let event = event as? ViewDidDisappearEvent {
            self.viewDidDisappear(event.animated, view: view, with: controller, on: event)
        }
    }
    
    @objc open func load(_ view: UIView?, with viewController: UIViewController, event: LoadViewEvent) {
    
    }
    
    @objc open func viewDidLoad(_ view: UIView?, with viewController: UIViewController, event: ViewDidLoadEvent) {
        
    }
    
    @objc open func viewWillAppear(_ animated: Bool, view: UIView?, with viewController: UIViewController, on event: ViewWillAppearEvent) {
        
    }
    
    @objc open func viewDidAppear(_ animated: Bool, view: UIView?, with viewController: UIViewController, on event: ViewDidAppearEvent) {
        
    }
    
    @objc open func viewWillDisappear(_ animated: Bool, view: UIView?, with viewController: UIViewController, on event: ViewWillDisappearEvent) {
       
    }
    
    @objc open func viewDidDisappear(_ animated: Bool, view: UIView?, with viewController: UIViewController, on event: ViewDidDisappearEvent) {
      
    }
}



