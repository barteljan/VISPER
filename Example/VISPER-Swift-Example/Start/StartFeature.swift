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
import VISPER_Redux
import VISPER_Reactive

struct StartViewState {
    let timesOpendAController : Int
}

struct IncrementTimesOpendAControllerAction : Action {
    
}

class StartFeature: ViewFeature,PresenterFeature, LogicFeature{
    
    let priority: Int = 0
    let routePattern: String
    let wireframe : Wireframe

    let stateObservableProperty: ObservableProperty<StartViewState>
    
    let actionDispatcher: ActionDispatcher
    let disposeBag = SubscriptionReferenceBag()
    
    init(routePattern: String,
           wireframe: Wireframe,
stateObservableProperty: ObservableProperty<StartViewState>,
    actionDispatcher: ActionDispatcher) {
        self.routePattern = routePattern
        self.wireframe = wireframe
        self.stateObservableProperty = stateObservableProperty
        self.actionDispatcher = actionDispatcher
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
                
               controller.state = StartViewState(timesOpendAController: 0)
        
               let reference = self.stateObservableProperty.subscribe({ (state) in
                    controller.state = state
               })
               self.disposeBag.addReference(reference: reference)
                
               controller.modalButtonPressed = {
                   try! self.wireframe.route(url: URL(string:"/modal/controller")!)
                   self.actionDispatcher.dispatch(IncrementTimesOpendAControllerAction())
               }
                
               controller.pushedButtonPressed = {
                   try! self.wireframe.route(url: URL(string:"/pushed/controller")!)
                   self.actionDispatcher.dispatch(IncrementTimesOpendAControllerAction())
               }
            
        })
    
        return [presenter]
    }
    
    func injectReducers(container: ReducerContainer) {
        
        let incrementReducer = FunctionalReducer { (provider: ReducerProvider, action: IncrementTimesOpendAControllerAction, state: StartViewState) -> StartViewState in
            let newState = StartViewState(timesOpendAController: state.timesOpendAController + 1)
            return newState
        }
        container.addReducer(reducer: incrementReducer)
    }
    
    
}
