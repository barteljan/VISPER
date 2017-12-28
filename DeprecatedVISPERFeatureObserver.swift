//
//  DeprecatedVISPERFeatureObserver.swift
//  JLRoutes
//
//  Created by bartel on 28.12.17.
//

import Foundation
import VISPER_Swift
import VISPER_Core
import VISPER_Objc

open class DeprecatedVISPERFeatureObserver<ApplicationState>: FeatureObserverType {
    
    public typealias AppState = ApplicationState
    
    let wireframe: Wireframe
    let commandBus: VISPERCommandBus
    
    public init(wireframe: Wireframe, commandBus: VISPERCommandBus){
        self.wireframe = wireframe
        self.commandBus = commandBus
    }
    
    public func featureAdded(application: Application<ApplicationState>, feature: Feature) throws {
        
        guard let visperFeature = feature as? DeprecatedVISPERFeatureWrapper else {
            return
        }
        
        let wireFrameObjc = WireframeObjc(wireframe: self.wireframe)
        let visperWireframe = VISPERWireframe(wireframe: wireFrameObjc)
        
        if let bootstrapWireframe = visperFeature.visperFeature.bootstrapWireframe {
            bootstrapWireframe(visperWireframe,self.commandBus)
        }
        
        if let routepatterns = visperFeature.visperFeature.routePatterns {
            
            for routepattern in routepatterns() {
                if let pattern = routepattern as? String {
                    do {
                        try self.wireframe.add(routePattern: pattern)
                    } catch let error {
                        print("Error: \(error)")
                    }
                }
            }
            
        }
        
    }
    
}
