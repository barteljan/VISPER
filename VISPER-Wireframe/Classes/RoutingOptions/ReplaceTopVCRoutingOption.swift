//
//  ReplaceTopVCRoutingOption.swift
//  VISPER-Wireframe
//
//  Created by bartel on 08.12.17.
//

import Foundation

import VISPER_Wireframe_Core

public protocol ReplaceTopVCRoutingOption : AnimatedRoutingOption{
    
}

public struct DefaultReplaceTopVCRoutingOption: ReplaceTopVCRoutingOption {
    
    public let animated: Bool
    
    public init(animated: Bool = true) {
        self.animated = animated
    }
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        
        guard let otherOption = otherOption as? ReplaceTopVCRoutingOption else {
            return false
        }
        
        return self.animated == otherOption.animated
    }
}
