//
//  DefaultComposedTopControllerResolver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 26.12.17.
//

import Foundation
import VISPER_Core

open class DefaultComposedTopControllerResolver: ComposedTopControllerResolver {
    
    public init(){}
    
    var wrappers: [ResolverWrapper] = [ResolverWrapper]()
    
    open func isResponsible(controller: UIViewController) -> Bool {
        return true
    }
    
    open func topController(of controller: UIViewController) -> UIViewController {
        
        for wrapper in self.wrappers {
            if wrapper.resolver.isResponsible(controller: controller){
                let newController = wrapper.resolver.topController(of: controller)
                
                if controller == newController {
                    return newController
                } else {
                    return self.topController(of: newController)
                }
            }
        }
        
        return controller
    }
    
    open func add(resolver: TopControllerResolver, priority: Int) {
        let wrapper = ResolverWrapper(resolver: resolver, priority: priority)
        self.add(wrapper: wrapper)
    }
    
    func add(wrapper: ResolverWrapper){
        self.wrappers.append(wrapper)
        self.wrappers.sort { (lhs, rhs) -> Bool in
            return lhs.priority > rhs.priority
        }
    }
    
    struct ResolverWrapper{
        let resolver: TopControllerResolver
        let priority: Int
    }
}
