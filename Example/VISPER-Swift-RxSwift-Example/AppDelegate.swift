//
//  AppDelegate.swift
//  VISPER-Swift-Example
//
//  Created by bartel on 09.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit
import VISPER
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApplication: AnyVISPERApp<AppState>!
    var disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //create root view controller
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
    
        //create visper application
        self.visperApplication = self.makeVISPERApplication()
        
        //add root view controller to visper application
        self.visperApplication?.navigateOn(navigationController)
        
        //add all features to visper application
        self.addFeatures()
        
        //route to start view
        try! self.visperApplication.wireframe.route(url: URL(string: "/start")!)
        
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func makeVISPERApplication() -> AnyVISPERApp<AppState>!{
        
        let appState = AppState(startViewState: StartViewState(timesOpendAController: 0))
        
        let appReducer: AppReducer<AppState> = { (reducerProvider:ReducerProvider, action: Action, state: AppState) -> AppState in
            return AppState(startViewState: reducerProvider.reduce(action: action, state: state.startViewState))
        }
        
        let applicationFactory = AppFactory<AppState>()
        
        let application = applicationFactory.makeApplication(initialState: appState,
                                                               appReducer: appReducer)
        
        return application
    }
    
    func addFeatures(){
        
        let appStateObservable = self.visperApplication.redux.store.observableState.asObservable()
        
        let startViewStateObservable = appStateObservable.map { (appstate) -> StartViewState in
            return appstate.startViewState
        }
        
        let startFeature = StartFeature(routePattern: "/start",
                                           wireframe: self.visperApplication.wireframe,
                                     stateObservable: startViewStateObservable,
                                    actionDispatcher: self.visperApplication.redux.actionDispatcher)
        
        try! self.visperApplication.add(feature: startFeature)
        
        let pushedFeature = PushedFeature(routePattern: "/pushed/controller")
        try! self.visperApplication.add(feature: pushedFeature)
        
        let modalFeature = ModalFeature(routePattern: "/modal/controller",
                                           wireframe: self.visperApplication.wireframe)
        try! self.visperApplication.add(feature: modalFeature)
        
    }


}

struct AppState {
    var startViewState: StartViewState
}
