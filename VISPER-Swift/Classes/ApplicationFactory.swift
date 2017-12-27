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
        self.addDefaultTopControllerResolvers(application: application)
        self.addDefaultControllerDismisser(application: application)
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
        
        //add them with low priority to make customization easy
        let modalRoutingPresenter = ModalRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: modalRoutingPresenter, priority: -1000)
        
        let pushRoutingPresenter = PushRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: pushRoutingPresenter, priority: -1000)
        
        let replaceTopVCRoutingPresenter = ReplaceTopVCRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: replaceTopVCRoutingPresenter, priority: -1000)
        
        let rootVCRoutingPresenter = RootVCRoutingPresenter(controllerContainer: controllerContainer)
        application.wireframe.add(routingPresenter: rootVCRoutingPresenter, priority: -1000)
        
    }
    
    open func addDefaultTopControllerResolvers(application: AnyApplication<AppState>) {
        
        //add them with low priority to make customization easy
        let navigationControllerResolver = NavigationControllerTopControllerResolver()
        application.wireframe.add(topControllerResolver: navigationControllerResolver, priority: -1000)
        
        let tabbarControllerResolver = TabbarControllerTopControllerResolver()
        application.wireframe.add(topControllerResolver: tabbarControllerResolver, priority: -1000)
        
        //since this is the most general resolver, it shoul be called last
        let childVCControllerResolver = ChildViewControllerTopControllerResolver()
        application.wireframe.add(topControllerResolver: childVCControllerResolver, priority: -5000)
        
        //add modal resolver with higher than default priority (modal presented controller are nearly always the top vc's)
        let modalVCControllerResolver = ModalViewControllerTopControllerResolver()
        application.wireframe.add(topControllerResolver: modalVCControllerResolver, priority: 1000)
        
    }
    
    open func addDefaultControllerDismisser(application: AnyApplication<AppState>) {
        
        let modalDismisser = ModalControllerDismisser()
        application.wireframe.add(controllerDimisser: modalDismisser, priority: 0)
        
        let navigationControllerDismisser = NavigationControllerDismisser()
        application.wireframe.add(controllerDimisser: navigationControllerDismisser, priority: 0)
    }
    
}

