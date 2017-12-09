//
//  RoutingOptionObjc.swift
//  Pods-VISPER-Wireframe_Example
//
//  Created by Jan Bartel on 20.11.17.
//

import Foundation
import VISPER_Wireframe_Core

@objc open class RoutingOptionObjc : NSObject, RoutingOption {
   
    open let routingOption : RoutingOption
    
    public init(routingOption : RoutingOption){
        self.routingOption = routingOption
    }
    
    open func isEqual(otherOption: RoutingOption?) -> Bool {
        return self.routingOption.isEqual(otherOption:otherOption)
    }
    
}
