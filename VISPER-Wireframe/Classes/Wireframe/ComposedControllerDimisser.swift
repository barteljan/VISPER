//
//  ComposedControllerDimisser.swift
//  JLRoutes
//
//  Created by bartel on 27.12.17.
//

import Foundation
import VISPER_Core

public protocol ComposedControllerDimisser: ControllerDismisser {
    func add(controllerDimisser: ControllerDismisser,priority: Int)
}
