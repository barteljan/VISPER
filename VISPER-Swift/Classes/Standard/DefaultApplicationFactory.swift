//
//  DefaultApplicationFactory.swift
//  JLRoutes
//
//  Created by bartel on 25.12.17.
//

import Foundation
import VISPER_Core
import VISPER_Reactive
import VISPER_Wireframe
import VISPER_UIViewController
import VISPER_Redux

open class DefaultApplicationFactory<AppState>: ApplicationFactory<AppState,DefaultObservableProperty<AppState>> {
    
     open func makeApplication(_ initialState: AppState,
                                   appReducer: @escaping (ReducerProvider, Action, AppState) -> AppState,
                                    wireframe: Wireframe = DefaultWireframe(),
                          controllerContainer: ControllerContainer = DefaultControllerContainer()) -> DefaultApplication<AppState> {
        
        let observableProperty = DefaultObservableProperty(initialState)
        
        return super.makeApplication(initialState: observableProperty,
                                       appReducer: appReducer,
                                        wireframe: wireframe,
                              controllerContainer: controllerContainer)
        
    }
}
