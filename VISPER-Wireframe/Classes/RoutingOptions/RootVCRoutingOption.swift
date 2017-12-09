//
//  RootVCRoutingOption.swift
//  VISPER-Wireframe
//
//  Created by bartel on 08.12.17.
//

import Foundation

import VISPER_Wireframe_Core

public protocol RootVCRoutingOption : AnimatedRoutingOption{
    
}

public struct DefaultRootVCRoutingOption: RootVCRoutingOption{
    
    public let animated: Bool
    
    public init(animated: Bool = true) {
        self.animated = animated
    }
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        
        guard let otherOption = otherOption as? RootVCRoutingOption else {
            return false
        }
        
        return self.animated == otherOption.animated
    }
}
