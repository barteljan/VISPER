//
//  ChildViewControllerTopControllerResolver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 26.12.17.
//

import Foundation
import VISPER_Core

open class ChildViewControllerTopControllerResolver: TopControllerResolver {
    
    public init(){}
    
    open func isResponsible(controller: UIViewController) -> Bool {
        return controller.childViewControllers.count > 0
    }
    
    open func topController(of controller: UIViewController) -> UIViewController {
        
        if controller.childViewControllers.count == 0 {
            return controller
        } else {
            return controller.childViewControllers.last!
        }
        
    }
    
    
}
