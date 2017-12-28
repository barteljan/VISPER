//
//  RoutingOptionBackTo.swift
//  VISPER-Wireframe
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

public protocol RoutingOptionBackTo: AnimatedRoutingOption {
    
}

public struct DefaultRoutingBackTo: RoutingOptionShow{
    
    public let animated: Bool
    
    public init(animated: Bool = true) {
        self.animated = animated
    }
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        
        guard let otherOption = otherOption as? RoutingOptionBackTo else {
            return false
        }
        
        return self.animated == otherOption.animated
    }
}
