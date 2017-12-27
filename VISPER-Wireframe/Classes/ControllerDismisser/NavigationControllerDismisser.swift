//
//  NavigationControllerDismisser.swift
//  VISPER-Wireframe
//
//  Created by bartel on 27.12.17.
//

import Foundation
import VISPER_Core

open class NavigationControllerDismisser: ControllerDismisser{
    
    public init(){}
    
    open func isResponsible(animated: Bool, controller: UIViewController) -> Bool {
        return controller.navigationController != nil
    }
    
    open func dismiss(animated: Bool, controller: UIViewController, completion: @escaping () -> Void) {
        
        if let navigationController = controller.navigationController {
            navigationController.popViewController(animated: animated, completion: completion)
        }
    }
    
    
}

extension UINavigationController {
    func popViewController(animated: Bool, completion: @escaping () -> ()) {
        popViewController(animated: animated)
        
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
