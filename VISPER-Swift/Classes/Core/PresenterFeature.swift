//
//  PresenterFeature.swift
//  VISPER-Swift
//
//  Created by bartel on 15.12.17.
//

import Foundation
import VISPER_Core

public protocol PresenterFeature: Feature, PresenterProvider {
    
    /// features with high priority will be handeled earlier than features with a low priority
    /// eg. high priority features might block low priority features
    var priority : Int {get}
    
}

public extension PresenterFeature where Self : ViewFeature {
    public func isResponsible(routeResult: RouteResult, controller: UIViewController) -> Bool {
        return self.isResponsible(routeResult: routeResult)
    }
}
