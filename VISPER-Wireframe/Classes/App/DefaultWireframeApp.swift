//
//  DefaultWireframeApp.swift
//  Pods-VISPER-Entity-Example
//
//  Created by bartel on 04.07.18.
//

import Foundation
import VISPER_Core

open class DefaultWireframeApp: DefaultApp, WireframeApp {
    
    public var wireframe: Wireframe
    
    internal var wireframeFeatureObservers = [WireframeFeatureObserver]()
    
    public init(wireframe: Wireframe) {
        self.wireframe = wireframe
        UIViewController.enableLifecycleEvents()
    }
    
    open override func add(feature: Feature) throws {
        
        try super.add(feature: feature)
        
        for observer in self.wireframeFeatureObservers {
            try observer.featureAdded(application: self, feature: feature)
        }
        
    }
    
    public func add(featureObserver: WireframeFeatureObserver) {
        self.wireframeFeatureObservers.append(featureObserver)
    }
    
    
    
}
