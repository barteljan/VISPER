//
//  ComposedRoutingOptionProvider.swift
//  VISPER-Wireframe_Tests
//
//  Created by bartel on 21.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import VISPER_Wireframe_Core

open class DefaultComposedRoutingOptionProvider : ComposedRoutingOptionProvider {
    
    var optionProviders: [OptionProviderWrapper]
    
    public init() {
        self.optionProviders = [OptionProviderWrapper]()
    }
    
    /// Add an instance providing routing options for a route
    ///
    /// - Parameters:
    ///   - optionProvider: instance providing routing options for a route
    ///   - priority: The priority for calling your provider, higher priorities are called first. (Defaults to 0)
    open func add(optionProvider: RoutingOptionProvider, priority: Int) {
        let wrapper = OptionProviderWrapper(priority: priority, optionProvider: optionProvider)
        self.addOptionProviderWrapper(wrapper: wrapper)
    }
    
    /// Provide a default routing option if your child providers are responsible for this route pattern parameter combination.
    /// The default behaviour should preserve a already determined option (currentOption) for this route pattern.
    /// But a RoutingOptionProvider can be used to replace a given option with an other option.
    ///
    /// - Parameters:
    ///   - routePattern: the route pattern for which a routing option has to be determined
    ///   - parameters: some additional data for creating the view controller presented by this routing option
    ///   - currentOption: The currently determined routing option - Be careful to overwrite it only on purpose
    /// - Returns: A default routing option if you are responsible for this route, nil otherwise
    open func option(routeResult: RouteResult) -> RoutingOption? {
        
        var routingOption : RoutingOption? = routeResult.routingOption
        
        for optionProviderWrapper in self.optionProviders.reversed() {
            routingOption = optionProviderWrapper.optionProvider.option(routeResult: routeResult)
        }
        
        return routingOption
        
    }
    
    func addOptionProviderWrapper(wrapper: OptionProviderWrapper) {
        self.optionProviders.append(wrapper)
        self.optionProviders.sort { (wrapper1, wrapper2) -> Bool in
            return wrapper1.priority > wrapper2.priority
        }
    }
    
    struct OptionProviderWrapper {
        let priority : Int
        let optionProvider : RoutingOptionProvider
    }
    
}
