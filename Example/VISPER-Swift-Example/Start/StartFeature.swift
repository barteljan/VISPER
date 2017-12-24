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

import RxSwift

struct StartViewState {
    let timesOpendAController : Int
}

struct IncrementTimesOpendAControllerAction : Action {
    
}

class StartFeature: ViewFeature,PresenterFeature, LogicFeature{
    
    let priority: Int = 0
    let routePattern: String
    let wireframe : Wireframe
    
    let stateObservable : Observable<StartViewState>
    let actionDispatcher: ActionDispatcher
    
    init(routePattern: String,
           wireframe: Wireframe,
     stateObservable: Observable<StartViewState>,
    actionDispatcher: ActionDispatcher) {
        self.routePattern = routePattern
        self.wireframe = wireframe
        self.stateObservable = stateObservable
        self.actionDispatcher = actionDispatcher
    }
    
    func makeOption(routeResult: RouteResult) -> RoutingOption {
        return DefaultPushRoutingOption()
    }
    
    func makeController(routeResult: RouteResult) throws -> UIViewController {
        return StartViewController(nibName: "StartViewController", bundle: nil)
    }
    
    let disposeBag = DisposeBag()
    
    
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
                
               self.stateObservable.subscribe(onNext: { (state) in
                   controller.state = state
               }).disposed(by: self.disposeBag)
 
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
