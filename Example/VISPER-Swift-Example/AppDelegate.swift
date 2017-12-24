//
//  AppDelegate.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 09.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit
import VISPER_Swift
import VISPER_Reactive
import VISPER_Core
import VISPER_Redux
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApplication: AnyApplication<RxSwiftObservableProperty<AppState>>!
    var disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
    
        let startViewState = StartViewState(timesOpendAController: 0)
        let appState = AppState(startViewState: startViewState)
        let initialState = RxSwiftObservableProperty<AppState>(appState)
        
        let appReducer: AppReducer<AppState> = { (reducerProvider:ReducerProvider, action: Action, state: AppState) -> AppState in
            let startViewState = reducerProvider.reduce(action: action, state: state.startViewState)
            let newState = AppState(startViewState: startViewState)
            return newState
        }
        
        let applicationFactory = ApplicationFactory<AppState,RxSwiftObservableProperty<AppState>>()
        
        self.visperApplication = applicationFactory.makeApplication(initialState: initialState, appReducer: appReducer)
        
        self.visperApplication?.add(controllerToNavigate: navigationController)
        
        let appStateObservable = self.visperApplication.redux.store.observable.asObservable()
        
        let startViewStateObservable = appStateObservable.map { (appstate) -> StartViewState in
            return appstate.startViewState
        }
        
        let startFeature = StartFeature(routePattern: "/start",wireframe: self.visperApplication.wireframe,stateObservable:startViewStateObservable, actionDispatcher: self.visperApplication.redux.actionDispatcher)
        
        try! self.visperApplication.add(feature: startFeature)
        
        let pushedFeature = PushedFeature(routePattern: "/pushed/controller")
        try! self.visperApplication.add(feature: pushedFeature)
        
        let modalFeature = ModalFeature(routePattern: "/modal/controller")
        try! self.visperApplication.add(feature: modalFeature)
        
        try! self.visperApplication.wireframe.route(url: URL(string: "/start")!)
        
        self.window?.makeKeyAndVisible()
        return true
    }


}

struct AppState {
    var startViewState: StartViewState
}
