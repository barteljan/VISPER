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
    
    public init(){}
    
    /// create a default application
    open func makeApplication(  redux: Redux<AppState>,
                           wireframe: Wireframe,
                 controllerContainer: ControllerContainer) -> AnyApplication<AppState> {
        
        let application = Application(redux: redux,
                                wireframe: wireframe,
                      controllerContainer: controllerContainer)
        let anyApplication = AnyApplication(application)
        self.configure(application: anyApplication,controllerContainer: controllerContainer)
        return anyApplication
        
    }
    
    /// create a default application
    open func makeApplication(initialState: AppState,
                                appReducer: @escaping AppReducer<AppState>,
                                 wireframe: Wireframe = DefaultWireframe(),
                       controllerContainer: ControllerContainer = DefaultControllerContainer()
        ) -> AnyApplication<AppState>{

        let redux = Redux( appReducer: appReducer,
                         initialState: initialState)
        return self.makeApplication(redux: redux,
                            wireframe: wireframe,
                  controllerContainer:controllerContainer)
        
    }
    
    /// configure an application
    open func configure(application: AnyApplication<AppState>,
               controllerContainer: ControllerContainer) {
        self.addDefaultFeatureObserver(application: application, controllerContainer: controllerContainer)
        self.addDefaultRoutingPresenters(application: application, controllerContainer: controllerContainer)
    }
    
    open func addDefaultFeatureObserver(application: AnyApplication<AppState>,
                               controllerContainer: ControllerContainer){
        let viewFeatureObserver = ViewFeatureObserver<AppState>()
        application.add(featureObserver: viewFeatureObserver)
        
        let presenterFeatureObserver = PresenterFeatureObserver<AppState>()
        application.add(featureObserver: presenterFeatureObserver)
        
        let logicFeatureObserver = LogicFeatureObserver<AppState>()
        application.add(featureObserver: logicFeatureObserver)
    }
    
    open func addDefaultRoutingPresenters(application: AnyApplication<AppState>,
                                 controllerContainer: ControllerContainer) {
        
        let modalRoutingPresenter = ModalRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: modalRoutingPresenter)
        
        let pushRoutingPresenter = PushRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: pushRoutingPresenter)
        
        let replaceTopVCRoutingPresenter = ReplaceTopVCRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: replaceTopVCRoutingPresenter)
        
        let rootVCRoutingPresenter = RootVCRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: rootVCRoutingPresenter)
        
    }
    
}
