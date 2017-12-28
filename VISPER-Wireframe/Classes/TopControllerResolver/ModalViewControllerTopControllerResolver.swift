//
//  ModalViewControllerTopViewControllerResolver.swift
//
//  Created by bartel on 26.12.17.
//

import Foundation
import VISPER_Core

open class ModalViewControllerTopControllerResolver: TopControllerResolver {
    
    public init(){}
    
    open func isResponsible(controller: UIViewController) -> Bool {
        return controller.presentedViewController != nil
    }
    
    open func topController(of controller: UIViewController) -> UIViewController {
        if let topController = controller.presentedViewController {
            return topController
        }
        return controller
    }
    
}
