//
//  File.swift
//  VISPER-Wireframe-Protocols
//
//  Created by bartel on 21.11.17.
//

import Foundation
import VISPER_Wireframe_Core

public protocol ComposedRoutingOptionProvider : RoutingOptionProvider {
    
    /// Add an instance providing routing options for a route
    ///
    /// - Parameters:
    ///   - optionProvider: instance providing routing options for a route
    ///   - priority: The priority for calling your provider, higher priorities are called last. (Defaults to 0)
    func add(optionProvider: RoutingOptionProvider, priority: Int)
    
}
