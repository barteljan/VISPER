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
import VISPER_Reactive

/// a factory to create a default SwiftyVISPER application
public class ApplicationFactory<AppState, DisposableType: SubscriptionReferenceType> {
    
    
    /// create a default application
    open func makeApplication( wireframe: Wireframe,
                                   redux: Redux<AppState,DisposableType>) -> AnyApplication<AppState,DisposableType> {
        
        let application = Application(wireframe: wireframe, redux: redux)
        self.configure(application: application)
        return AnyApplication(application)
        
    }
    
    /// create a default application
    open func makeApplication(initialState : AnyObservableProperty<AppState,DisposableType>,
                                  wireframe: Wireframe = DefaultWireframe()) -> AnyApplication<AppState,DisposableType>{

        let redux = Redux(initialState: initialState)
        return self.makeApplication(wireframe: wireframe, redux: redux)
        
    }
    
    /// configure an application
    open func configure(application: Application<AppState,DisposableType>) {
        
        let viewFeatureObserver = ViewFeatureObserver<AppState,DisposableType>()
        application.add(featureObserver: viewFeatureObserver)
        
        let logicFeatureObserver = LogicFeatureObserver<AppState,DisposableType>()
        application.add(featureObserver: logicFeatureObserver)
        
    }
    
}

