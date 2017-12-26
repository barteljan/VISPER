//
//  ComposedTopControllerResolver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 26.12.17.
//

import Foundation
import VISPER_Core

public protocol ComposedTopControllerResolver: TopControllerResolver{
    func add(resolver: TopControllerResolver, priority: Int)
}
