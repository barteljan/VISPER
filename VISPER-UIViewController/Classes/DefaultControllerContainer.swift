//
//  DefaultViewControllerContainer.swift
//  VISPER-UIViewController
//
//  Created by bartel on 15.12.17.
//

import Foundation
import UIKit
import VISPER_Core

open class DefaultControllerContainer: ControllerContainer {
    
    var controllers = [ControllerWrapper]()
    
    open func add(controller: UIViewController) {
        self.clean()
        let wrapper = ControllerWrapper(controller: controller)
        self.controllers.append(wrapper)
    }
    
    open func remove(controller: UIViewController) {
        var indexes = [Int]()
        
        for (i,wrapper) in self.controllers.enumerated() {
            if wrapper.controller == nil || wrapper.controller == controller {
                indexes.append(i)
            }
        }
        
        for index in indexes.reversed() {
            self.controllers.remove(at: index)
        }
    }
    
    public func getController(matches: (UIViewController?) -> Bool) -> UIViewController? {
        self.clean()
        
        for wrapper in self.controllers.reversed() {
            if matches(wrapper.controller) {
                return wrapper.controller
            }
        }
        
        return nil
    }
    
    func clean() {
        var indexes = [Int]()
        
        for (i,wrapper) in self.controllers.enumerated() {
            if wrapper.controller == nil {
                indexes.append(i)
            }
        }
        
        for index in indexes.reversed() {
            self.controllers.remove(at: index)
        }
    }
    
    struct ControllerWrapper {
        weak var controller: UIViewController?
    }
}
