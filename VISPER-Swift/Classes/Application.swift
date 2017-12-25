//
//  Application.swift
//  SwiftyVISPER
//
//  Created by bartel on 15.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Core
import VISPER_Wireframe
import VISPER_UIViewController
import VISPER_Reactive

/// A SwiftyVisper application, containing all dependencies which should be configured by features
open class Application<AppState> : ApplicationType {
    
    public typealias ApplicationObservableProperty = ObservableProperty<AppState>
    
    public init(redux: Redux<AppState>,
          wireframe: Wireframe,
controllerContainer: ControllerContainer){
        self.wireframe = wireframe
        self.redux = redux
        self.controllerContainer = controllerContainer
        UIViewController.enableLifecycleEvents()
    }
    
    /// observable app state property
    open var state: ObservableProperty<AppState> {
        return redux.store.observableState
    }
    
    /// the wireframe responsible for routing between your view controllers
    public let wireframe: Wireframe
    
    //redux architecture of your project
    public let redux: Redux<AppState>
    
    public let controllerContainer: ControllerContainer
    
    internal var featureObserver: [AnyFeatureObserver<AppState>] = [AnyFeatureObserver<AppState>]()
    
    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    open func add(feature: Feature) throws {
        
        for observer in self.featureObserver {
            try observer.featureAdded(application: self, feature: feature)
        }
        
    }
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    open func add<T : FeatureObserverType>(featureObserver: T) where T.AppState == AppState{
        let anyObserver = AnyFeatureObserver<AppState>(featureObserver)
        self.featureObserver.append(anyObserver)
    }
    
    
    /// Add a controller that can be used to navigate in your app.
    /// Typically this will be a UINavigationController, but it could also be a UITabbarController if
    /// you have a routing presenter that can handle it.
    /// Be careful you can add more than one viewControllers if your RoutingPresenters can handle different
    /// controller types or when the active 'rootController' changes.
    /// The last added controller will be used first.
    /// The controller will not be retained by the application (it is weakly stored), you need to store a
    /// link to them elsewhere (if you don't want them to be removed from memory).
    /// - Parameter controllerToNavigate: a controller that can be used to navigte in your app
    open func add(controllerToNavigate: UIViewController) {
        self.controllerContainer.add(controller: controllerToNavigate)
    }
    
}




