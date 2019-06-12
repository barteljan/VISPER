//
//  AppDelegate.swift
//  VISPER-Redux
//
//  Created by Jan Barteljan on 10/31/2017.
//  Copyright (c) 2017 barteljan. All rights reserved.
//

import UIKit
import VISPER_Redux
import VISPER_Reactive
import VISPER_Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    var redux  : Redux<AppState>!
    
    var disposeBag = SubscriptionReferenceBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //create inial app state
        let initialState = AppState(counterState: CounterState(counter: 0))
       
        //add a middleware that prints every dispatched action
        let middleware = Middleware<AppState>().sideEffect { getState, dispatch, action in
            print(action)
        }
        
        //create the main reducer of your app
        let appReducer : AppReducer<AppState> = { provider, action, state -> AppState in
            var newState = AppState(
                counterState: provider.reduce(action: action, state: state.counterState)
            )
            newState = provider.reduce(action: action, state: newState)
            return newState
        }
        
        // create a Redux-Container (to have all components on one place)
        self.redux = Redux<AppState>(   appReducer: appReducer,
                                      initialState: initialState,
                                        middleware: middleware)
        
        // add your reducers
        self.redux.reducerContainer.addReduceFunction(reduceFunction: incrementReducer)
        
        let decrementReducer = DecrementReducer(state: redux.store.observableState.map({ return $0.counterState }))
        
        self.redux.reducerContainer.addReducer(reducer: decrementReducer)
        self.redux.reducerContainer.addReducer(reducer: CounterStateReducer())
        
        //create your view controller, give it a dependency for dispatching actions
        let controller = ExampleViewController(actionDispatcher: self.redux.actionDispatcher)
        self.window?.rootViewController = controller
        
        //register the callback to update your vc
        let subscription = self.redux.store.observableState.subscribe { appState in
            controller.state = appState.counterState
        }
        self.disposeBag.addReference(reference: subscription)
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

