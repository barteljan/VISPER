//
//  ViewControllerContainer.swift
//  Pods
//
//  Created by bartel on 15.12.17.
//

import Foundation
import UIKit

public protocol ControllerContainer {
    func addUnretained(controller: UIViewController)
    func remove(controller: UIViewController)
    func getController(matches: (_ controller: UIViewController?) -> Bool) -> UIViewController?
}

public extension ControllerContainer {
    
    @available(*, deprecated, renamed: "addUnretained", message: "This method will be removed in a future release - use addUnretained instead")
    func add(controller: UIViewController) {
        self.addUnretained(controller: controller)
    }
    
}
