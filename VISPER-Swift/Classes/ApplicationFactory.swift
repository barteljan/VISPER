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
public class ApplicationFactory<ObservableProperty: ObservablePropertyType> {
    
    /// create a default application
    open func makeApplication(  redux: Redux<ObservableProperty>,
                           wireframe: Wireframe,
                 controllerContainer: ControllerContainer) -> AnyApplication<ObservableProperty> {
        
        let application = Application(redux: redux,
                                wireframe: wireframe,
                      controllerContainer: controllerContainer)
        let anyApplication = AnyApplication(application)
        self.configure(application: anyApplication,controllerContainer: controllerContainer)
        return anyApplication
        
    }
    
    /// create a default application
    open func makeApplication(initialState : ObservableProperty,
                                 wireframe: Wireframe = DefaultWireframe(),
                       controllerContainer: ControllerContainer = DefaultControllerContainer()
        ) -> AnyApplication<ObservableProperty>{

        let redux = Redux(initialState: initialState)
        return self.makeApplication(redux: redux,
                            wireframe: wireframe,
                  controllerContainer:controllerContainer)
        
    }
    
    /// configure an application
    open func configure(application: AnyApplication<ObservableProperty>,
               controllerContainer: ControllerContainer) {
        self.addDefaultFeatureObserver(application: application, controllerContainer: controllerContainer)
        self.addDefaultRoutingPresenters(application: application, controllerContainer: controllerContainer)
    }
    
    open func addDefaultFeatureObserver(application: AnyApplication<ObservableProperty>,
                               controllerContainer: ControllerContainer){
        let viewFeatureObserver = ViewFeatureObserver<ObservableProperty>()
        application.add(featureObserver: viewFeatureObserver)
        
        let presenterFeatureObserver = PresenterFeatureObserver<ObservableProperty>()
        application.add(featureObserver: presenterFeatureObserver)
        
        let logicFeatureObserver = LogicFeatureObserver<ObservableProperty>()
        application.add(featureObserver: logicFeatureObserver)
    }
    
    open func addDefaultRoutingPresenters(application: AnyApplication<ObservableProperty>,
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

