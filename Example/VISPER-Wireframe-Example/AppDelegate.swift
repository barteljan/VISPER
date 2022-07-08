//
//  AppDelegate.swift
//  VISPER-Wireframe-Example.md
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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let factory = DefaultWireframeAppFactory()
        let visperApp = factory.makeApp()
        self.visperApp = visperApp
        
        let navigationController = UINavigationController()
        visperApp.navigateOn(navigationController)
        window.rootViewController = navigationController
        
        let startFeature = StartFeature(routePattern: "/start", wireframe: visperApp.wireframe)
        try! visperApp.add(feature: startFeature)
        
        let messageFeature = MessageFeature()
        try! visperApp.add(feature: messageFeature)
        
        let swiftUIView = SwiftUIExampleView()
        let swiftUIFeature = ContentFeature(routePattern: "/swiftui",content: swiftUIView)
        try! visperApp.add(feature: swiftUIFeature)
        
        try! visperApp.wireframe.route(url: URL(string: "/start")!)
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

