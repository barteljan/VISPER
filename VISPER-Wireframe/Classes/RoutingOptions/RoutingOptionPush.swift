//
//  File.swift
//  VISPER-Core
//
//  Created by bartel on 07.12.17.
//

import Foundation
import VISPER_Core

public protocol RoutingOptionPush : AnimatedRoutingOption{
    var animationTransition: UIViewAnimationTransition? {get}
    var animationDuration: TimeInterval {get}
}

public struct DefaultRoutingOptionPush: RoutingOptionPush{
   
    public let animated: Bool
    public var animationTransition: UIViewAnimationTransition?
    public var animationDuration: TimeInterval
    
    public init(animated: Bool = true, animationTransition: UIViewAnimationTransition? = nil, animationDuration: TimeInterval = 0.6) {
        self.animated = animated
        self.animationTransition = animationTransition
        self.animationDuration = animationDuration
    }
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        
        guard let otherOption = otherOption as? RoutingOptionPush else {
            return false
        }
        
        return self.animated == otherOption.animated && self.animationTransition == otherOption.animationTransition
    }
}
