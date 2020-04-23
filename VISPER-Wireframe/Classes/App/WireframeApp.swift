//
//  NavigationControllerDismisser.swift
//  VISPER-Wireframe
//
//  Created by bartel on 27.12.17.
//

import Foundation
import VISPER_Core

public protocol WireframeApp: App, ControllerContainer {
    
    /// the wireframe responsible for routing between your view controllers
    var wireframe: Wireframe {get}
    
    /// Add an observer to configure your application after adding a feature.
    /// Have look at LogicFeature and LogicFeatureObserver for an example.
    ///
    /// - Parameter featureObserver: an object observing feature addition
    func add(featureObserver: WireframeFeatureObserver)
    
    /// Add a controller that can be used to navigate in your app.
    /// Typically this will be a UINavigationController, but it could also be a UITabbarController if
    /// you have a routing presenter that can handle it.
    /// Be careful you can add more than one viewControllers if your RoutingPresenters can handle different
    /// controller types or when the active 'rootController' changes.
    /// The last added controller will be used first.
    /// The controller will not be retained by the application (it is weakly stored), you need to store a
    /// link to them elsewhere (if you don't want them to be removed from memory).
    /// - Parameter controller: a controller that can be used to navigte in your app
    func navigateOn(_ controller: UIViewController)
    
    /// return the first navigatableController that matches in a block
    func controllerToNavigate(matches: (_ controller: UIViewController?) -> Bool) -> UIViewController?
    
}

public extension WireframeApp {
    
    @available(*, deprecated, renamed: "navigateOn", message: "This method will be removed in a future release - use navigateOn instead -be aware that neither of this functions will retain your VC")
    func add(controllerToNavigate: UIViewController) {
        self.navigateOn(controllerToNavigate)
    }
    
    func navigateOn(_ controller: UIViewController){
        self.wireframe.navigateOn(controller)
    }
    
    func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        return self.wireframe.controllerToNavigate(matches:matches)
    }
    
    func addUnretained(controller: UIViewController) {
        self.navigateOn(controller)
    }
    
    func remove(controller: UIViewController) {
        self.wireframe.remove(controller: controller)
    }
    
    func getController(matches: (_ controller: UIViewController?) -> Bool) -> UIViewController? {
        return self.controllerToNavigate(matches: matches)
    }
    
}
