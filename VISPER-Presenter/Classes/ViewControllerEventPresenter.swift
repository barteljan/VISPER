//
//  ViewControllerEventPresenter.swift
//  VISPER-Presenter
//
//  Created by bartel on 13.12.17.
//

import Foundation
import VISPER_Objc

@objc public protocol ViewControllerEventPresenter {
    func isResponsibleFor(event: NSObject,view: UIView?,controller: UIViewController) -> Bool
    func receivedEvent(event: NSObject, view: UIView?, controller: UIViewController)
}

