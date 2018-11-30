//
//  StartFeature.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 30.11.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Swift

class StartFeature: ViewFeature {
    
    let routePattern: String
    
    // you can ignore the priority for the moment
    // it is sometimes needed when you want to "override"
    // an already added Feature
    let priority: Int = 0
    let wireframe: Wireframe
    let actionDispatcher: ActionDispatcher
    let userName: ObservableProperty<String?>
    
    init(routePattern: String, wireframe: Wireframe,actionDispatcher: ActionDispatcher, userName: ObservableProperty<String?>){
        self.routePattern = routePattern
        self.wireframe = wireframe
        self.userName = userName
        self.actionDispatcher = actionDispatcher
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
        return [StartPresenter(userName: self.userName, wireframe: self.wireframe, actionDipatcher: self.actionDispatcher)]
    }
    
}

extension StartFeature: LogicFeature {
    func injectReducers(container: ReducerContainer) {
        container.addReducer(reducer: ChangeUserNameReducer())
    }
}
