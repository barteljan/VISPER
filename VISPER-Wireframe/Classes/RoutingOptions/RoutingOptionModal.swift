//
//  RoutingOptionModal.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Core

public protocol RoutingOptionModal : AnimatedRoutingOption{
    var presentationStyle: UIModalPresentationStyle? {get}
    var transitionStyle: UIModalTransitionStyle? {get}
}

public struct DefaultRoutingOptionModal: RoutingOptionModal{
    
    public let animated: Bool
    public let presentationStyle : UIModalPresentationStyle?
    public let transitionStyle: UIModalTransitionStyle?
    
    public init(  animated: Bool = true,
         presentationStyle: UIModalPresentationStyle? = nil,
         transitionStyle: UIModalTransitionStyle? = nil) {
        self.animated = animated
        self.presentationStyle = presentationStyle
        self.transitionStyle = transitionStyle
    }
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        
        guard let otherOption = otherOption as? RoutingOptionModal else {
            return false
        }
        
        return self.animated == otherOption.animated &&
            self.presentationStyle == otherOption.presentationStyle &&
            self.transitionStyle == otherOption.transitionStyle
    }
}
