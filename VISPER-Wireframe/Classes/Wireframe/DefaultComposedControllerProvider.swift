//
//  DefaultComposedControllerProvider.swift
//  VISPER-Wireframe
//
//  Created by bartel on 22.11.17.
//

import Foundation
import VISPER_Core

public enum DefaultComposedControllerProviderError : Error {
    case noControllerFoundFor(routeResult: RouteResult)
}


public class DefaultComposedControllerProvider : ComposedControllerProvider {
    
    var controllerProviders: [ProviderWrapper]

    public init(){
        self.controllerProviders = [ProviderWrapper]()
    }
    
    public func add(controllerProvider: ControllerProvider, priority: Int) {
        let wrapper = ProviderWrapper(priority: priority, controllerProvider: controllerProvider)
        self.addRoutingProviderWrapper(wrapper: wrapper)
    }
    
    public func isResponsible(routeResult: RouteResult) -> Bool {
        for wrapper in self.controllerProviders {
            if wrapper.controllerProvider.isResponsible(routeResult: routeResult) {
                return true
            }
        }
        return false
    }
    
    public func priorityOfHighestResponsibleProvider(routeResult: RouteResult) -> Int? {
        
        for wrapper in self.controllerProviders {
            if wrapper.controllerProvider.isResponsible(routeResult: routeResult) {
                return wrapper.priority
            }
        }
        
        return nil
    }
    
    public func makeController(routeResult: RouteResult) throws -> UIViewController {
        
        for wrapper in self.controllerProviders {
            
            let controllerProvider = wrapper.controllerProvider
            
            if controllerProvider.isResponsible(routeResult: routeResult) {
                return try controllerProvider.makeController(routeResult: routeResult)
            }
        }
        
        throw DefaultComposedControllerProviderError.noControllerFoundFor(routeResult: routeResult)

        
    }
    
    //MARK: some helper structs
    struct ProviderWrapper {
        let priority : Int
        let controllerProvider : ControllerProvider
    }
    
    //MARK: some helper functions
    func addRoutingProviderWrapper(wrapper: ProviderWrapper) {
        self.controllerProviders.append(wrapper)
        self.controllerProviders.sort { (wrapper1, wrapper2) -> Bool in
            return wrapper1.priority > wrapper2.priority
        }
    }
    
    
}
