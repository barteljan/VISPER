//
//  ModalRoutingOption.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by bartel on 08.12.17.
//

import Foundation
import VISPER_Wireframe_Core

public protocol ModalRoutingOption : AnimatedRoutingOption{
    var presentationStyle: UIModalPresentationStyle? {get}
    var transitionStyle: UIModalTransitionStyle? {get}
}

public struct DefaultModalRoutingOption: ModalRoutingOption{
    
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
        
        guard let otherOption = otherOption as? ModalRoutingOption else {
            return false
        }
        
        return self.animated == otherOption.animated &&
            self.presentationStyle == otherOption.presentationStyle &&
            self.transitionStyle == otherOption.transitionStyle
    }
}
