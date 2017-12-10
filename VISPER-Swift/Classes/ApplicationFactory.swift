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
import VISPER_Reactive

/// a factory to create a default SwiftyVISPER application
public class ApplicationFactory<ObservableProperty: ObservablePropertyType> {
    
    
    /// create a default application
    open func makeApplication( wireframe: Wireframe,
                                   redux: Redux<ObservableProperty>) -> AnyApplication<ObservableProperty> {
        
        let application = Application(wireframe: wireframe, redux: redux)
        self.configure(application: application)
        return AnyApplication(application)
        
    }
    
    /// create a default application
    open func makeApplication(initialState : ObservableProperty,
                                  wireframe: Wireframe = DefaultWireframe()) -> AnyApplication<ObservableProperty>{

        let redux = Redux(initialState: initialState)
        return self.makeApplication(wireframe: wireframe, redux: redux)
        
    }
    
    /// configure an application
    open func configure(application: Application<ObservableProperty>) {
        
        let viewFeatureObserver = ViewFeatureObserver<ObservableProperty>()
        application.add(featureObserver: viewFeatureObserver)
        
        let logicFeatureObserver = LogicFeatureObserver<ObservableProperty>()
        application.add(featureObserver: logicFeatureObserver)
        
    }
    
}

