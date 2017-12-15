//
//  FunctionalOptionProvider.swift
//  Pods
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core

open class FunctionalRoutingOptionProvider : RoutingOptionProvider {
    
    typealias OptionCallback = (_ routeResult: RouteResult) -> RoutingOption?
    
    let optionCallback: OptionCallback
    
    public init(optionCallback: OptionCallback){
        self.optionCallback = optionCallback
    }
    
    public func option(routeResult: RouteResult) -> RoutingOption? {
        return self.optionCallback(routeResult)
    }

}
