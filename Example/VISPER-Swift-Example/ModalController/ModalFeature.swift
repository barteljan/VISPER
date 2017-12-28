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
    let wireframe: Wireframe
    
    public init(routePattern: String,wireframe: Wireframe) {
        self.routePattern = routePattern
        self.wireframe = wireframe
    }
    
    public func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultRoutingOptionModal()
    }
    
    public func makeController(routeResult: RouteResult) throws -> UIViewController {
        return ModalViewController(nibName: "ModalViewController", bundle: nil)
    }
    
    public func makePresenters(routeResult: RouteResult, controller: UIViewController) throws -> [Presenter] {
        
        let actionPresenter = FunctionalPresenter(
            
            isResponsibleCallback: { (routeResult, controller) -> Bool in
                return routeResult.routePattern == self.routePattern
            },
            
            addPresentationLogic: { (routeResult, controller) in
                guard let controller = controller as? ModalViewController else {
                    fatalError("should use only a ModalViewController")
                }
                controller.exitCallBack = {
                    self.wireframe.dismissTopViewController(animated: true, completion: {})
                }
            }
        )
        
        return [actionPresenter]
    }
    
}
