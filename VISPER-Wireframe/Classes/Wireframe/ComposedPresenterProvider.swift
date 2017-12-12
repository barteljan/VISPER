//
//  File.swift
//  VISPER-Wireframe
//
//  Created by bartel on 11.12.17.
//

import Foundation
import VISPER_Core

public protocol ComposedPresenterProvider : PresenterProvider {
    
    /// Add an instance providing a presenter for a route
    ///
    /// - Parameters:
    ///   - provider: instance providing a presenter
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    func add(provider: PresenterProvider, priority: Int) 
}
