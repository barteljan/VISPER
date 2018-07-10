//
//  AppDelegate.swift
//  VISPER-Redux-Sourcery-Example
//
//  Created by bartel on 24.03.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import UIKit
import VISPER

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var visperApplication: AnyVISPERApp<AppState>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let factory = GeneratedApplicationFactoryForAppState()
        let appState = AppState(styleState: StyleState(backgroundColor: .yellow, fontColor: .blue),
                                userState: UserState(firstName: "Jan",
                                                      lastName: "Bartel",
                                                      userName: "bartel",
                                                         email: "barteljan@yahoo.de"))
        
        do {
            self.visperApplication = try factory.makeApplication(initialState: appState)
        } catch let error {
            fatalError("Error:\(error)")
        }
        
        self.window?.rootViewController = ViewController()
        
        self.window?.makeKeyAndVisible()
        return true
    }


}

