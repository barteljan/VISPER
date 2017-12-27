//
//  DefaultComposedControllerDismisser.swift
//  VISPER-Wireframe
//
//  Created by bartel on 27.12.17.
//

import Foundation
import VISPER_Core

public class DefaultComposedControllerDismisser: ComposedControllerDimisser {
    
    public init(){}
    
    var dismissers = [Wrapper]()
    
    public func add(controllerDimisser: ControllerDismisser, priority: Int) {
        let wrapper = Wrapper(dismisser: controllerDimisser, priority: priority)
        self.add(wrapper: wrapper)
    }
    
    public func isResponsible(animated: Bool, controller: UIViewController) -> Bool {
        for wrapper in dismissers {
            if wrapper.dismisser.isResponsible(animated: animated, controller: controller) {
                return true
            }
        }
        return false
    }
    
    public func dismiss(animated: Bool,
                      controller: UIViewController,
                      completion: @escaping () -> Void) {
        for wrapper in dismissers {
            if wrapper.dismisser.isResponsible(animated: animated, controller: controller) {
                wrapper.dismisser.dismiss(animated: animated,
                                        controller: controller,
                                        completion: completion)
                return
            }
        }
    }
    
    func add(wrapper: Wrapper){
        self.dismissers.append(wrapper)
        self.dismissers.sort { (lhs, rhs) -> Bool in
            return lhs.priority > rhs.priority
        }
    }
    
    struct Wrapper {
        let dismisser: ControllerDismisser
        let priority: Int
    }
    
}
