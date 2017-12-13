//
//  UIViewController+Wireframe.swift
//  JLRoutes
//
//  Created by bartel on 13.12.17.
//

import Foundation
import VISPER_UIViewController
import VISPER_Core

public extension UIViewController {
    var routeResult: RouteResult? {
        return self.routeResultObjc?.routeResult
    }
}
