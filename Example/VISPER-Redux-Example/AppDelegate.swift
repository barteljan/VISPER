//
//  AppDelegate.swift
//  VISPER-Redux
//
//  Created by Jan Barteljan on 10/31/2017.
//  Copyright (c) 2017 barteljan. All rights reserved.
//

import UIKit
import VISPER_Redux

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    var redux  : Redux<AppState>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //create inial app state
        let initialState = AppState(counterState: CounterState(counter: 0))
       
        //add a middleware that prints every dispatched action
        let middleware = Middleware<AppState>().sideEffect { getState, dispatch, action in
            print(action)
        }
        
        //create the main reducer of your app
        let appReducer : AppReducer<AppState> = { provider, action, state -> AppState in
            return AppState(
                counterState: provider.reduce(action: action, state: state.counterState)
            )
        }
        
        // create a Redux-Container (to have all components on one place)
        self.redux = Redux<AppState>(   appReducer: appReducer,
                                      initialState: initialState,
                                        middleware: middleware)
        
        // add your reducers
        self.redux.reducerContainer.addReduceFunction(reduceFunction: incrementReducer)
        self.redux.reducerContainer.addReducer(reducer: DecrementReducer())
        
        //create your view controller, give it a dependency for dispatching actions
        let controller = ExampleViewController(actionDispatcher: self.redux.actionDispatcher)
        self.window?.rootViewController = controller
        
        //register the callback to update your vc
        self.redux.store.observable.subscribe { appState in
            controller.state = appState.counterState
        }
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

