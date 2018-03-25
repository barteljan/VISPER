//
//  AppDelegate.swift
//  VISPER-Redux-Sourcery-Example
//
//  Created by bartel on 24.03.18.
//  Copyright © 2018 Jan Bartel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = ViewController()
        
        self.window?.makeKeyAndVisible()
        return true
    }


}

