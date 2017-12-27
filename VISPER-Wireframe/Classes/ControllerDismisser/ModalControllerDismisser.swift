//
//  ModalControllerDismisser.swift
//  VISPER-Wireframe
//
//  Created by bartel on 27.12.17.
//

import Foundation
import VISPER_Core

open class ModalControllerDismisser: ControllerDismisser{
    
    public init(){}
    
    open func isResponsible(animated: Bool, controller: UIViewController) -> Bool {
        return controller.presentingViewController != nil
    }
    
    open func dismiss(animated: Bool, controller: UIViewController, completion: @escaping () -> Void) {
        controller.dismiss(animated: animated, completion: completion)
    }
    
}
