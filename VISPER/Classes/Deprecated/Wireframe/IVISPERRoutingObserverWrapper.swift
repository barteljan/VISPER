//
//  IVISPERRoutingObserverWrapper.swift
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

struct IVISPERRoutingObserverWrapper: RoutingObserver {
    
    let observer: IVISPERRoutingObserver
    let wireframe: VISPERWireframe
    
    func willPresent(controller: UIViewController,
                    routeResult: RouteResult,
               routingPresenter: RoutingPresenter?,
                      wireframe: Wireframe) throws {
        
        guard let option = try! VISPERWireframe.routingOption(routingOption: routeResult.routingOption) else {
            return
        }
        
        let presenter = RoutingPresenterWrapper(presenter: routingPresenter,
                                     wireframe: self.wireframe)
        
        self.observer.route(to: controller,
                  routePattern: routeResult.routePattern,
                       options: option,
                    parameters: self.convert(dict: routeResult.parameters),
              routingPresenter: presenter,
                     wireframe: self.wireframe)
    }
    
    func convert(dict: [String : Any]) -> [AnyHashable : Any] {
        var result = [AnyHashable : Any]()
        for key in dict.keys {
            result[key] = dict[key]
        }
        return result
    }
}
