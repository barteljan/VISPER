//
//  VISPER.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Wireframe_Core
import VISPER_Wireframe

/// a factory to create a default SwiftyVISPER application
public class ApplicationFactory<AppState> {
    
    
    /// create a default application
    open func makeApplication( wireframe: Wireframe,
                                   redux: Redux<AppState>) -> AnyApplication<AppState> {
        
        let application = Application(wireframe: wireframe, redux: redux)
        self.configure(application: application)
        return AnyApplication(application)
        
    }
    
    /// create a default application
    open func makeApplication(initialState : AppState,
                                  wireframe: Wireframe = DefaultWireframe()) -> AnyApplication<AppState>{

        let redux = Redux(initialState: initialState)
        return self.makeApplication(wireframe: wireframe, redux: redux)
        
    }
    
    /// configure an application
    open func configure(application: Application<AppState>) {
        
        let viewFeatureObserver = ViewFeatureObserver<AppState>()
        application.add(featureObserver: viewFeatureObserver)
        
        let logicFeatureObserver = LogicFeatureObserver<AppState>()
        application.add(featureObserver: logicFeatureObserver)
        
    }
    
}

