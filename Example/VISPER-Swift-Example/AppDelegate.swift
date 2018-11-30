//
//  AppDelegate.swift
//  VISPER-Wireframe-Example.md
//
//  Created by bartel on 09.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit
import VISPER_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var visperApp: AnyVISPERApp<AppState>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        self.visperApp = self.createApp()
        
        let navigationController = UINavigationController()
        visperApp.add(controllerToNavigate: navigationController)
        window.rootViewController = navigationController
        
        let startFeature = StartFeature(routePattern: "/start",
                                           wireframe: visperApp.wireframe,
                                    actionDispatcher: visperApp.redux.actionDispatcher,
                                            userName: visperApp.redux.store.observableState.map({ return $0.userState.userName }))
        try! visperApp.add(feature: startFeature)
        
        let messageFeature = MessageFeature()
        try! visperApp.add(feature: messageFeature)
        
        try! visperApp.wireframe.route(url: URL(string: "/start")!)
        
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func createApp() -> AnyVISPERApp<AppState> {
        let initalState: AppState = AppState(userState: UserState(userName: "unknown stranger"))
        
        let appReducer: AppReducer<AppState> = { (reducerProvider: ReducerProvider, action: Action, state: AppState) -> AppState in
            let newState = AppState(userState: reducerProvider.reduce(action: action, state: state.userState))
            return reducerProvider.reduce(action: action, state: newState)
        }
        
        let appFactory = VISPERAppFactory<AppState>()
        return appFactory.makeApplication(initialState: initalState, appReducer: appReducer)
    }
    
}

