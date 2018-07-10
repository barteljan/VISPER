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

@available(*, unavailable, message: "replace this class with VISPERApp",renamed: "VISPERApp")
public typealias Application<AppState> = VISPERApp<AppState>

/// A SwiftyVisper application, containing all dependencies which should be configured by features
open class VISPERApp<AppState>: VISPERAppType, ReduxApp, WireframeApp {
   
    
    
    public typealias ApplicationObservableProperty = ObservableProperty<AppState>
    
    internal let reduxApp: AnyReduxApp<AppState>
    internal let wireframeApp: WireframeApp
    
    public init(reduxApp: AnyReduxApp<AppState>,
            wireframeApp: WireframeApp)  {
        self.reduxApp = reduxApp
        self.wireframeApp = wireframeApp
    }
    
    
    public convenience init(reduxApp: AnyReduxApp<AppState>,
                           wireframe: Wireframe,
                 controllerContainer: ControllerContainer) {
        let wireframeApp = DefaultWireframeApp(wireframe: wireframe,
                                               controllerContainer: controllerContainer)
        self.init(reduxApp: reduxApp, wireframeApp: wireframeApp)
        
    }
    
    
    public convenience init(redux: Redux<AppState>,
                        wireframe: Wireframe,
              controllerContainer: ControllerContainer){
        
        let reduxApp = DefaultReduxApp(redux: redux)
        let anyReduxApp = AnyReduxApp(reduxApp)
        self.init(reduxApp: anyReduxApp,
                 wireframe: wireframe,
       controllerContainer: controllerContainer)
    }
    
    
    /// observable app state property
    open var state: ObservableProperty<AppState> {
        get {
            return self.reduxApp.redux.store.observableState
        }
    }
    
    /// the wireframe responsible for routing between your view controllers
    public var wireframe: Wireframe {
        get {
            return self.wireframeApp.wireframe
        }
    }
    
    //redux architecture of your project
    public var redux: Redux<AppState> {
        get {
            return self.reduxApp.redux
        }
    }
    
    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    open func add(feature: Feature) throws {
        try self.reduxApp.add(feature: feature)
        try self.wireframeApp.add(feature: feature)
    }
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    open func add<T : StatefulFeatureObserver>(featureObserver: T) where T.AppState == AppState{
        self.reduxApp.add(featureObserver: featureObserver)
    }
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    open func add(featureObserver: FeatureObserver) {
        self.reduxApp.add(featureObserver: featureObserver)
    }
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    public func add(featureObserver: WireframeFeatureObserver) {
        self.wireframeApp.add(featureObserver: featureObserver)
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
        self.wireframeApp.add(controllerToNavigate: controllerToNavigate)
    }
    
    
    /// return the first navigatableController that matches in a block
    public func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        return self.wireframeApp.controllerToNavigate(matches: matches)
    }
    
}




