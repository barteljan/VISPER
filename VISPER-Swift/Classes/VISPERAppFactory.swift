//
//  VISPERAppFactory.swift
//  Pods-HikingGallery
//
//  Created by bartel on 17.11.18.
//

import Foundation
import VISPER_Core
import VISPER_Redux
import VISPER_UIViewController

open class VISPERAppFactory<AppState>  {
    
    public init(){}
    
    /// create a default application
    open func makeApplication(initialState: AppState,
                                appReducer: @escaping AppReducer<AppState>,
                                 wireframe: Wireframe? = nil,
                       controllerContainer: ControllerContainer = DefaultControllerContainer(),
                                middleware: Middleware<AppState> = Middleware<AppState>()) -> AnyVISPERApp<AppState> {
        let redux = Redux( appReducer: appReducer,
                           initialState: initialState,
                           middleware: middleware)
        
        return self.makeApplication(redux: redux, wireframe: wireframe, controllerContainer: controllerContainer)
    }
    
    /// create a default application
    open func makeApplication(initialState: AppState,
                              wireframe: Wireframe? = nil,
                              controllerContainer: ControllerContainer = DefaultControllerContainer(),
                              middleware: Middleware<AppState> = Middleware<AppState>()) -> AnyVISPERApp<AppState> {
        let redux = Redux(initialState: initialState, middleware: middleware)
        return self.makeApplication(redux: redux, wireframe: wireframe, controllerContainer: controllerContainer)
    }
    
    /// create a default application
    open func makeApplication( redux: Redux<AppState>,
                           wireframe: Wireframe? = nil,
                 controllerContainer: ControllerContainer = DefaultControllerContainer()) -> AnyVISPERApp<AppState> {
        
        let reduxAppFactory = ReduxAppFactory<AppState>()
        
        let reduxApp = reduxAppFactory.makeApplication(redux: redux)
        
        let wireframeAppFactory = DefaultWireframeAppFactory()
        let wireframeApp = wireframeAppFactory.makeApp(wireframe: wireframe,
                                                       controllerContainer: controllerContainer)
        
        
        let visperApp = VISPERApp<AppState>(reduxApp: reduxApp, wireframeApp: wireframeApp)
        return AnyVISPERApp(visperApp)
    }
    
}
