//
//  FunctionalOptionProvider.swift
//  Pods
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core

open class FunctionalRoutingOptionProvider : RoutingOptionProvider {
    
    public typealias OptionCallback = (_ routeResult: RouteResult) -> RoutingOption?
    
    public let optionCallback: OptionCallback
    
    public init(optionCallback:@escaping OptionCallback){
        self.optionCallback = optionCallback
    }
    
    open func option(routeResult: RouteResult) -> RoutingOption? {
        return self.optionCallback(routeResult)
    }

}
