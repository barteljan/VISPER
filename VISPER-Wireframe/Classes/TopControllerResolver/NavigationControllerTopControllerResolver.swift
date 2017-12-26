//
//  NavigationControllerTopControllerResolver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 26.12.17.
//

import Foundation
import VISPER_Core

open class NavigationControllerTopControllerResolver: TopControllerResolver {
    
    public init(){}
    
    open func isResponsible(controller: UIViewController) -> Bool {
      return controller is UINavigationController
    }
    
    open func topController(of controller: UIViewController) -> UIViewController {
        
        guard let navigationController = controller as? UINavigationController else {
            return controller
        }
        
        guard let topController = navigationController.topViewController else {
            return navigationController
        }
        
        return topController
    }
    
    
}
