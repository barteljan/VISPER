//
//  TopControllerResolver.swift
//  VISPER-Wireframe
//
//  Created by bartel on 26.12.17.
//

import Foundation

public protocol TopControllerResolver {
    func isResponsible(controller: UIViewController) -> Bool
    func topController(of controller: UIViewController) -> UIViewController
}




