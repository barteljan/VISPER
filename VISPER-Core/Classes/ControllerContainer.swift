//
//  ViewControllerContainer.swift
//  Pods
//
//  Created by bartel on 15.12.17.
//

import Foundation
import UIKit

public protocol ControllerContainer {
    func add(controller: UIViewController)
    func remove(controller: UIViewController)
    func getController(matches: (_ controller: UIViewController?) -> Bool) -> UIViewController?
}


