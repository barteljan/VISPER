//
//  ApplicationType.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import UIKit
import VISPER_Redux
import VISPER_Core
import VISPER_UIViewController
import VISPER_Reactive


/// A SwiftyVisper application type, containing all dependencies which should be configured by features
public protocol ApplicationType {
    
    associatedtype ApplicationState
    
    /// observable app state property
    var state: ObservableProperty<ApplicationState> {get}
    
    /// the wireframe responsible for routing between your view controllers
    var wireframe: Wireframe {get}
    
    //redux architecture of your project
    var redux : Redux<ApplicationState> {get}
    
    /// Add a feature to your application
    ///
    /// - Parameter feature: your feature
    /// - Throws: throws errors thrown by your feature observers
    ///
    /// - note: A Feature is an empty protocol representing a distinct funtionality of your application.
    ///         It will be provided to all FeatureObservers after addition to configure and connect it to
    ///         your application and your remaining features. Have look at LogicFeature and LogicFeatureObserver for an example.
    func add(feature: Feature) throws
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    func add<T : FeatureObserverType>(featureObserver: T) where T.AppState == ApplicationState
    
    
    /// Add a controller that can be used to navigate in your app.
    /// Typically this will be a UINavigationController, but it could also be a UITabbarController if
    /// you have a routing presenter that can handle it.
    /// Be careful you can add more than one viewControllers if your RoutingPresenters can handle different
    /// controller types or when the active 'rootController' changes.
    /// The last added controller will be used first.
    /// The controller will not be retained by the application (it is weakly stored), you need to store a
    /// link to them elsewhere (if you don't want them to be removed from memory).
    /// - Parameter controllerToNavigate: a controller that can be used to navigte in your app
    func add(controllerToNavigate: UIViewController)
    
    /// return the first navigatableController that matches in a block
    func controllerToNavigate(matches: (_ controller: UIViewController?) -> Bool) -> UIViewController?
    
}
