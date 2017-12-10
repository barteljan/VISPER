//
//  File.swift
//  VISPER-Core
//
//  Created by bartel on 07.12.17.
//

import Foundation
import VISPER_Core

public protocol PushRoutingOption : AnimatedRoutingOption{
    
}

public struct DefaultPushRoutingOption: PushRoutingOption{
    
    public let animated: Bool
    
    public init(animated: Bool = true) {
        self.animated = animated
    }
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        
        guard let otherOption = otherOption as? PushRoutingOption else {
            return false
        }
        
        return self.animated == otherOption.animated
    }
}
