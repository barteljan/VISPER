//
//  RoutingOptionRootVC.swift
//  VISPER-Wireframe
//
//  Created by bartel on 08.12.17.
//

import Foundation

import VISPER_Core

public protocol RoutingOptionRootVC : AnimatedRoutingOption{
    
}

public struct DefaultRoutingOptionRootVC: RoutingOptionRootVC{
    
    public let animated: Bool
    
    public init(animated: Bool = true) {
        self.animated = animated
    }
    
    public func isEqual(otherOption: RoutingOption?) -> Bool {
        
        guard let otherOption = otherOption as? RoutingOptionRootVC else {
            return false
        }
        
        return self.animated == otherOption.animated
    }
}
