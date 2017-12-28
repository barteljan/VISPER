//
//  RoutingPresenterWrapper.swift
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

class RoutingPresenterWrapper: NSObject,IVISPERRoutingPresenter {

    let presenter: RoutingPresenter?
    let routingOptionConverter: RoutingOptionConverter
    let wireframe: VISPERWireframe
    
    init(                presenter: RoutingPresenter?,
            routingOptionConverter: RoutingOptionConverter,
                         wireframe: VISPERWireframe){
        self.presenter = presenter
        self.wireframe = wireframe
        self.routingOptionConverter = routingOptionConverter
    }
    
    func isResponsible(for routingOption: IVISPERRoutingOption!) -> Bool {
        
        guard let presenter = self.presenter else {
            return false
        }
        
        let option = try! self.routingOptionConverter.routingOption(visperRoutingOption: routingOption)
        
        let result = RouteResultWrapper(routePattern: "", routingOption: option, parameters: [:])
        
        return presenter.isResponsible(routeResult: result)
    }
    
    func route(forPattern routePattern: String!,
                            controller: UIViewController!,
                               options: IVISPERRoutingOption!,
                            parameters: [AnyHashable : Any]!,
                          on wireframe: IVISPERWireframe!,
                            completion: ((String?, UIViewController?, IVISPERRoutingOption?, [AnyHashable : Any]?, IVISPERWireframe?) -> Void)!) {
        
        guard let presenter = self.presenter else {
            completion(routePattern,
                       controller,
                       options,
                       parameters,
                       wireframe)
            return
        }
        
        let option = try! self.routingOptionConverter.routingOption(visperRoutingOption: options)
        
        let routeResult = RouteResultWrapper(routePattern: routePattern,
                                            routingOption: option,
                                               parameters: self.convert(dict: parameters))
        
        try! presenter.present(controller: controller,
                              routeResult: routeResult,
                                wireframe: self.wireframe.wireframe.wireframe,
                                 delegate: FakeRoutingDelegate(),
                                 completion: {
                                    completion(routePattern,
                                               controller,
                                               options,
                                               parameters,
                                               wireframe)
        })
    }
    
    
    func convert(dict: [AnyHashable : Any]) -> [String : Any] {
        var result = [String : Any]()
        for key in dict.keys {
            if let key = key as? String {
                result[key] = dict[key]
            }
        }
        return result
    }
    
    struct RouteResultWrapper: RouteResult {
        var routePattern: String
        var routingOption: RoutingOption?
        var parameters: [String : Any]
    }
    
    struct FakeRoutingDelegate: RoutingDelegate {
        var routingObserver: RoutingObserver?
        
        public init(){
            self.routingObserver = nil
        }
        
        func willPresent(controller: UIViewController,
                        routeResult: RouteResult,
                   routingPresenter: RoutingPresenter?,
                          wireframe: Wireframe) throws {
        
        }
        
        func didPresent(controller: UIViewController,
                       routeResult: RouteResult,
                  routingPresenter: RoutingPresenter?,
                         wireframe: Wireframe) {
            
        }
    }
    
    
    
}
