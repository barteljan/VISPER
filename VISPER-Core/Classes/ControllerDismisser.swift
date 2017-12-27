//
//  DismissControllerPresenter.swift
//  JLRoutes
//
//  Created by bartel on 27.12.17.
//

import Foundation

public protocol ControllerDismisser {
    func isResponsible(animated:Bool,controller: UIViewController) -> Bool
    func dismiss(animated:Bool,controller: UIViewController,completion: @escaping ()->Void)
}
