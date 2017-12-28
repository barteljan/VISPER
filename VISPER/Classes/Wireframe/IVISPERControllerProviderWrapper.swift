//
//  IVISPERControllerProviderWrapper.swift
//  JLRoutes
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

struct IVISPERControllerProviderWrapper: ControllerProvider {
    
    let controllerProvider: IVISPERControllerProvider
    let routingOptionConverter: RoutingOptionConverter
    
    func isResponsible(routeResult: RouteResult) -> Bool {
        
        if let isResponsible = controllerProvider.isResponsible {
            let option = try! self.routingOptionConverter.routingOption(routingOption: routeResult.routingOption)
            return isResponsible(routeResult.routePattern, option, self.convert(dict: routeResult.parameters))
        } else {
            guard let option = try! self.routingOptionConverter.routingOption(routingOption: routeResult.routingOption) else {
                return false
            }
            let controller = self.controllerProvider.controller(forRoute: routeResult.routePattern,
                                                                routingOptions: option,
                                                                withParameters: self.convert(dict: routeResult.parameters))
            return controller != nil
            
        }
    }
    
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        
        guard let option = try! self.routingOptionConverter.routingOption(routingOption: routeResult.routingOption) else {
            fatalError("cannot create controller with no option")
        }
        
        guard let controller = self.controllerProvider.controller(forRoute: routeResult.routePattern,
                                                                  routingOptions: option,
                                                                  withParameters: self.convert(dict: routeResult.parameters)) else {
                                                                    fatalError("cannot create controller")
        }
        
        return controller
    }
    
    
    func convert(dict: [String : Any]) -> [AnyHashable : Any] {
        var result = [AnyHashable : Any]()
        for key in dict.keys {
            result[key] = dict[key]
        }
        return result
    }
    
}
