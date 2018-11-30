//
//  HelloWorldFeature.swift
//  VISPER-Wireframe-Example.md
//
//  Created by bartel on 16.07.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import UIKit
import VISPER_Wireframe
import VISPER_Core

class StartFeature: ViewFeature {
    
    let routePattern: String
    
    // you can ignore the priority for the moment
    // it is sometimes needed when you want to "override"
    // an already added Feature
    let priority: Int = 0
    
    let wireframe: Wireframe
    
    init(routePattern: String, wireframe: Wireframe){
        self.routePattern = routePattern
        self.wireframe = wireframe
    }
    
    // create a blue controller which will be created when the "blue" route is called
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        let controller = StartViewController()
        return controller
    }
    
    // return a routing option to show how this controller should be presented
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionPush()
    }
}


extension StartFeature: PresenterFeature {
    
    func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        return [StartPresenter(userName: "unknown guy", wireframe: self.wireframe)]
    }
    
}
