//
//  AppDelegate.swift
//  VISPER-Wireframe-Example
//
//  Created by bartel on 09.12.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import UIKit
import VISPER_Wireframe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApp: WireframeApp?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let factory = DefaultWireframeAppFactory()
        let visperApp = factory.makeApp()
        self.visperApp = visperApp
        
        let navigationController = UINavigationController()
        visperApp.add(controllerToNavigate: navigationController)
        window.rootViewController = navigationController
        
        let blueFeature = BlueFeature(wireframe: visperApp.wireframe)
        try! visperApp.add(feature: blueFeature)
        
        let greenFeature = GreenFeature(wireframe: visperApp.wireframe)
        try! visperApp.add(feature: greenFeature)
        
        try! visperApp.wireframe.route(url: URL(string: blueFeature.routePattern)!)
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

