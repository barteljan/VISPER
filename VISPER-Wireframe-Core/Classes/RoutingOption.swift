//
//  RoutingOption.swift
//  VISPER-Wireframe
//
//  Created by bartel on 18.11.17.
//

import Foundation

/// A message object describing how the view controller presented after routing will be presented
public protocol RoutingOption {
    func isEqual(otherOption: RoutingOption?) -> Bool
}



