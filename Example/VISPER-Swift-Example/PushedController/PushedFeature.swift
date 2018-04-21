//
//  PushedFeature.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 17.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER

public class PushedFeature: ViewFeature, PresenterFeature {
   
    public var routePattern: String
    public var priority: Int = 0
    
    public init(routePattern: String) {
        self.routePattern = routePattern
    }
    
    public func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }
    
    public func makeController(routeResult: RouteResult) throws -> UIViewController {
        return UIViewController()
    }
    
    public func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
     
        let presenter = FunctionalControllerPresenter(isResponsibleCallback: { (routeResult, controller) -> Bool in
            return routeResult.routePattern == self.routePattern
        },  viewWillAppearCallback: { (animated, view, controller) in
            view.backgroundColor = UIColor.green
        })
        
        controller.add(controllerPresenter: presenter, priority: 0)
        
        return [presenter]
    }
    
}


