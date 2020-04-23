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
        
        let controllers = tabbarController.children
        
        if(controllers.count == 0) {
            return tabbarController
        }
            
        // intercept tabbar controller with more controller
        // since evry controller greater than the fifth is hidden in
        // a more navigation controller
        if(tabbarController.selectedIndex >= controllers.count) {
            return controllers.last!
        }
                
        return controllers[tabbarController.selectedIndex]
    }
    
    
}
