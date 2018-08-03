//
//  DefaultWireframeAppFactory.swift
//  VISPER-Wireframe
//
//  Created by bartel on 16.07.18.
//

import Foundation
import VISPER_Core
import VISPER_Presenter
import VISPER_UIViewController

open class DefaultWireframeAppFactory: WireframeAppFactory{
    
    open var wireframeFactory: WireframeFactory = WireframeFactory()
    
    public init(){}
    
    open func makeApp(wireframe: Wireframe? = nil,
                      controllerContainer: ControllerContainer = DefaultControllerContainer()) -> WireframeApp {
        
        var shouldNotBeNilWireframe = wireframe
        
        if shouldNotBeNilWireframe == nil {
            shouldNotBeNilWireframe = self.wireframeFactory.makeWireframe(controllerContainer: controllerContainer)
        }
        
        let app = DefaultWireframeApp(wireframe: shouldNotBeNilWireframe!)
        
        self.addDefaultFeatureObserver(application: app, controllerContainer: controllerContainer)
        self.wireframeFactory.configure(wireframe: shouldNotBeNilWireframe!, controllerContainer: controllerContainer)
        
        return app
    }
    
    open func addDefaultFeatureObserver(application: WireframeApp,
                                        controllerContainer: ControllerContainer){
        let viewFeatureObserver = ViewFeatureObserver()
        application.add(featureObserver: viewFeatureObserver)
        
        let presenterFeatureObserver = PresenterFeatureObserver()
        application.add(featureObserver: presenterFeatureObserver)
    }
    
}
