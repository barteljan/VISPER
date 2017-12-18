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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApplication: AnyApplication<RxSwiftObservableProperty<AppState>>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
    
        let appState = AppState()
        let initialState = RxSwiftObservableProperty<AppState>(appState)
        
        let applicationFactory = ApplicationFactory<RxSwiftObservableProperty<AppState>>()
        self.visperApplication = applicationFactory.makeApplication(initialState: initialState)
        
        self.visperApplication?.add(controllerToNavigate: navigationController)

        let startFeature = StartFeature(routePattern: "/start",wireframe: self.visperApplication.wireframe)
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

}
