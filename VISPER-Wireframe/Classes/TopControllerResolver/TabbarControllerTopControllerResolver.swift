//
//  TabbarControllerTopControllerResolver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 26.12.17.
//

import Foundation
import VISPER_Core

open class TabbarControllerTopControllerResolver: TopControllerResolver {
    
    public init(){}
    
    open func isResponsible(controller: UIViewController) -> Bool {
        return controller is UITabBarController
    }
    
    open func topController(of controller: UIViewController) -> UIViewController {
        
        guard let tabbarController = controller as? UITabBarController else {
            return controller
        }
        
        guard let controllers = tabbarController.viewControllers else {
            return tabbarController
        }
        
        return controllers[tabbarController.selectedIndex]
    }
    
    
}
