//
//  RoutingOptionProvider.swift
//  VISPER-Wireframe
//
//  Created by bartel on 18.11.17.
//

import Foundation

/// An instance providing a routing option, for a specific route pattern and parameter combinition.
/// The default behaviour should preserve a already determined option (currentOption) for this route pattern.
/// But a RoutingOptionProvider can be used to replace a given option with an other option.
public protocol RoutingOptionProvider {
    
    /// Provide a default routing option if you are responsible for this route pattern parameter combination.
    /// The default behaviour should preserve a already determined option (currentOption) for this route pattern.
    /// But a RoutingOptionProvider can be used to replace a given option with an other option.
    ///
    /// - Parameters:
    ///   - routePattern: the route pattern for which a routing option has to be determined
    ///   - parameters: some additional data for creating the view controller presented by this routing option
    ///   - currentOption: The currently determined routing option - Be careful to overwrite it only on purpose
    /// - Returns: A default routing option if you are responsible for this route, nil otherwise
    func option(  routeResult: RouteResult ) -> RoutingOption?
    
}
