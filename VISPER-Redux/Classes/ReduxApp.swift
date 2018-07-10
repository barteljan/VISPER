//
//  ReduxApp.swift
//  VISPER-Core
//
//  Created by bartel on 04.07.18.
//

import Foundation
import VISPER_Core
import VISPER_Reactive


public protocol ReduxApp: App {
    
    associatedtype ApplicationState
    
    /// observable app state property
    var state: ObservableProperty<ApplicationState> {get}
    
    ///redux architecture of your project
    var redux : Redux<ApplicationState> {get}
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    func add<T : StatefulFeatureObserver>(featureObserver: T) where T.AppState == ApplicationState
    
}



