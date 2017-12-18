//
//  ModalFeature.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 18.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation

import Foundation
import VISPER_Swift
import VISPER_Core
import VISPER_Wireframe
import VISPER_Presenter

public class ModalFeature: ViewFeature, PresenterFeature {

    public var routePattern: String
    public var priority: Int = 0
    
    public init(routePattern: String) {
        self.routePattern = routePattern
    }
    
    public func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultModalRoutingOption()
    }
    
    public func makeController(routeResult: RouteResult) throws -> UIViewController {
        return UIViewController()
    }
    
    public func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        
        let presenter = FunctionalControllerPresenter(isResponsibleCallback: { (routeResult, controller) -> Bool in
            return routeResult.routePattern == self.routePattern
        },  viewWillAppearCallback: { (animated, view, controller) in
            view.backgroundColor = UIColor.blue
        })
        
        controller.add(controllerPresenter: presenter, priority: 0)
        
        return [presenter]
    }
    
}
