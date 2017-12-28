//
//  IVISPERRoutingPresenterWrapper.swift
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

struct IVISPERRoutingPresenterWrapper: RoutingPresenter {
    
    let presenter: IVISPERRoutingPresenter
    let routingOptionConverter: RoutingOptionConverter
    let wireframe: IVISPERWireframe
    
    func isResponsible(routeResult: RouteResult) -> Bool {
        guard let option = try! self.routingOptionConverter.routingOption(routingOption: routeResult.routingOption) else {
            return false
        }
        return self.presenter.isResponsible(for: option)
    }
    
    func present(controller: UIViewController,
                routeResult: RouteResult,
                  wireframe: Wireframe,
                   delegate: RoutingDelegate,
                 completion: @escaping () -> ()) throws {
        
        guard let option = try self.routingOptionConverter.routingOption(routingOption: routeResult.routingOption) else {
            fatalError("cannot present without an option")
        }
        
        self.presenter.route(forPattern: routeResult.routePattern,
                             controller: controller,
                                options: option,
                             parameters: self.convert(dict: routeResult.parameters),
                             on: self.wireframe) { (routePattern, viewController, option, parameters, wireframe) in
                                completion()
        }
    
    }
    
    func convert(dict: [String : Any]) -> [AnyHashable : Any] {
        var result = [AnyHashable : Any]()
        for key in dict.keys {
            result[key] = dict[key]
        }
        return result
    }

}
