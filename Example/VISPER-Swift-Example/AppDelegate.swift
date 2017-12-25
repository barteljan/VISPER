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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApplication: AnyApplication<AppState>!
    var disposeBag = SubscriptionReferenceBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //create root view controller
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
    
        //create visper application
        self.visperApplication = self.makeVISPERApplication()
        
        //add root view controller to visper application
        self.visperApplication?.add(controllerToNavigate: navigationController)
        
        //add all features to visper application
        self.addFeatures()
        
        //route to start view
        try! self.visperApplication.wireframe.route(url: URL(string: "/start")!)
        
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func makeVISPERApplication() -> AnyApplication<AppState>!{
        
        let appState = AppState(startViewState: StartViewState(timesOpendAController: 0))
        
        let appReducer: AppReducer<AppState> = { (reducerProvider: ReducerProvider,
                                                           action: Action,
                                                            state: AppState) -> AppState in
            
            return AppState(startViewState: reducerProvider.reduce(action: action, state: state.startViewState))
            
        }
        
        let applicationFactory = ApplicationFactory<AppState>()
        
        let visperApplication = applicationFactory.makeApplication(initialState: appState,
                                                                     appReducer: appReducer)
        
        return visperApplication
    }
    
    func addFeatures(){
        
        let appStateObservableProperty = self.visperApplication.redux.store.observableState
        
        let startViewStateObservableProperty = appStateObservableProperty.map { (appstate) -> StartViewState in
            return appstate.startViewState
        }
        
        let startFeature = StartFeature(routePattern: "/start",
                                           wireframe: self.visperApplication.wireframe,
                             stateObservableProperty: startViewStateObservableProperty,
                                    actionDispatcher: self.visperApplication.redux.actionDispatcher)
        
        try! self.visperApplication.add(feature: startFeature)
        
        let pushedFeature = PushedFeature(routePattern: "/pushed/controller")
        try! self.visperApplication.add(feature: pushedFeature)
        
        let modalFeature = ModalFeature(routePattern: "/modal/controller")
        try! self.visperApplication.add(feature: modalFeature)
        
    }


}

struct AppState {
    var startViewState: StartViewState
}
