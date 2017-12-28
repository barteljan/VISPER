//
//  GetControllerRoutingOption.swift
//  VISPER-Wireframe
//
//  Created by bartel on 19.11.17.
//

import Foundation
import VISPER_Core

public protocol RoutingOptionGetController : RoutingOption{}

public struct DefaultRoutingOptionGetController : RoutingOptionGetController {
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        return otherOption is DefaultRoutingOptionGetController
    }
    
    public init(){}
}
