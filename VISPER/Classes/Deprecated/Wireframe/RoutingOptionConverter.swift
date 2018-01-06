//
//  RoutingOptionConverter.swift
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Core

public protocol RoutingOptionConverter {
    func routingOption(visperRoutingOption: IVISPERRoutingOption?) throws -> RoutingOption?
    func routingOption(routingOption: RoutingOption?) throws -> IVISPERRoutingOption?
}
