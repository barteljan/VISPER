//
//  IVISPERRoutingOptionsProviderWrapper.swift
//  VISPER
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

struct IVISPERRoutingOptionsProviderWrapper: RoutingOptionProvider {
    
    let provider: IVISPERRoutingOptionsProvider
    let routingOptionConverter: RoutingOptionConverter
    
    func option(routeResult: RouteResult) -> RoutingOption? {
        
        let currentOptions = try! self.routingOptionConverter.routingOption(routingOption: routeResult.routingOption)
        
        let result = self.provider.option(forRoutePattern: routeResult.routePattern,
                                               parameters: self.convert(dict: routeResult.parameters),
                                           currentOptions: currentOptions)
        
        return try! self.routingOptionConverter.routingOption(visperRoutingOption: result)
    }
    
    func convert(dict: [String : Any]) -> [AnyHashable : Any] {
        var result = [AnyHashable : Any]()
        for key in dict.keys {
            result[key] = dict[key]
        }
        return result
    }
    
    
}
