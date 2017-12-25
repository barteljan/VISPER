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

open class DefaultApplicationFactory<AppState>: ApplicationFactory<AppState> {
    
     open func makeApplication(_ initialState: AppState,
                                   appReducer: @escaping (ReducerProvider, Action, AppState) -> AppState,
                                    wireframe: Wireframe = DefaultWireframe(),
                          controllerContainer: ControllerContainer = DefaultControllerContainer()) -> AnyApplication<AppState> {
        
        return super.makeApplication(initialState: initialState,
                                       appReducer: appReducer,
                                        wireframe: wireframe,
                              controllerContainer: controllerContainer)
        
    }
}
