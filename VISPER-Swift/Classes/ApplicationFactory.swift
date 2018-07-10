//
//  VISPER.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Core
import VISPER_Wireframe
import VISPER_UIViewController

/// a factory to create a default SwiftyVISPER application
open class ApplicationFactory<AppState> {
    
    open var wireframeFactory: WireframeFactory = WireframeFactory()
    open var strictReduxMode: Bool = false
    
    public init(){}
    
    /// create a default application
    open func makeApplication(  redux: Redux<AppState>,
                           wireframe: Wireframe,
                 controllerContainer: ControllerContainer) -> AnyVISPERApp<AppState> {
        
        let application = VISPERApp(redux: redux,
                                wireframe: wireframe,
                      controllerContainer: controllerContainer)
        let anyApplication = AnyVISPERApp(application)
        self.configure(application: anyApplication, controllerContainer: controllerContainer)
        return anyApplication
        
    }
    
    /// create a default application
    open func makeApplication(initialState: AppState,
                                appReducer: @escaping AppReducer<AppState>,
                                 wireframe: Wireframe? = nil,
                       controllerContainer: ControllerContainer = DefaultControllerContainer()
        ) -> AnyVISPERApp<AppState>{

        var shouldNotBeNilWireframe = wireframe
        
        if shouldNotBeNilWireframe == nil {
            shouldNotBeNilWireframe = WireframeFactory().makeWireframe(controllerContainer: controllerContainer)
        }
        
        let redux = Redux( appReducer: appReducer,
                         initialState: initialState)
        return self.makeApplication(redux: redux,
                            wireframe: shouldNotBeNilWireframe!,
                  controllerContainer:controllerContainer)
        
    }
    
    /// configure an application
    open func configure(application: AnyVISPERApp<AppState>,
               controllerContainer: ControllerContainer) {
        self.addDefaultFeatureObserver(application: application, controllerContainer: controllerContainer)
        self.wireframeFactory.configure(wireframe: application.wireframe,controllerContainer: controllerContainer)
    }
    
    open func addDefaultFeatureObserver(application: AnyVISPERApp<AppState>,
                               controllerContainer: ControllerContainer){
        let viewFeatureObserver = ViewFeatureObserver()
        application.add(featureObserver: viewFeatureObserver)
        
        let presenterFeatureObserver = PresenterFeatureObserver()
        application.add(featureObserver: presenterFeatureObserver)
        
        let logicFeatureObserver = LogicFeatureObserver<AppState>()
        application.add(featureObserver: logicFeatureObserver)
        
        let stateObservingFeatureObserver = StateObservingFeatureObserver<AppState,AppState>(state: application.state)
        application.add(featureObserver: stateObservingFeatureObserver)
    }
    
}

