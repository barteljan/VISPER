//
//  StartFeature.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 17.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Swift
import VISPER_Core
import VISPER_Wireframe
import VISPER_Presenter

class StartFeature: ViewFeature,PresenterFeature{
    
    let priority: Int = 0
    let routePattern: String
    let wireframe : Wireframe
    
    init(routePattern: String, wireframe: Wireframe) {
        self.routePattern = routePattern
        self.wireframe = wireframe
    }
    
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultPushRoutingOption()
    }
    
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        return StartViewController(nibName: "StartViewController", bundle: nil)
    }
    
    func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        
        let presenter = FunctionalPresenter(
            isResponsibleCallback: { (routeResult, controller) -> Bool in
               return routeResult.routePattern == self.routePattern
            },
            addPresentationLogic: { (routeResult, controller) in

               guard let controller = controller as? StartViewController else{
                   fatalError("this presenter does only work with a start controller")
               }
            
               controller.modalButtonPressed = {
                   try! self.wireframe.route(url: URL(string:"/modal/controller")!)
               }
                
               controller.pushedButtonPressed = {
                   try! self.wireframe.route(url: URL(string:"/pushed/controller")!)
               }
            
        })
    
        return [presenter]
    }
    
}
