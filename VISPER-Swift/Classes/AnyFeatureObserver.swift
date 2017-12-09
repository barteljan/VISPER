//
//  AnyFeatureObserver.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation

// some base class needed for type erasure, ignore it if possible
class _AnyFeatureObserver<AppState> : FeatureObserverType{
    
    typealias ApplicationState = AppState

    func featureAdded(application: Application<AppState>, feature: Feature) throws {
        fatalError("override me")
    }
}

// some box class needed for type erasure, ignore it if possible
final class _AnyFeatureObserverBox<Base: FeatureObserverType>: _AnyFeatureObserver<Base.ApplicationState> {
    
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override func featureAdded(application: Application<Base.ApplicationState>, feature: Feature) throws {
        try self.base.featureAdded(application: application, feature: feature)
    }
}

/// Type erasure for the generic FeatureObserverType protocol
/// (you need this to reference it as a full type, to use it in arrays or variable definitions,
/// since generic protocols can only be used in generic definitions)
open class AnyFeatureObserver<AppState> : FeatureObserverType {
    
    private let box: _AnyFeatureObserver<ApplicationState>
    
    public typealias ApplicationState = AppState
    
    public init<Base: FeatureObserverType>(_ base: Base) where Base.ApplicationState == AppState {
        box = _AnyFeatureObserverBox(base)
    }
    
    open func featureAdded(application: Application<AppState>, feature: Feature) throws {
        try self.box.featureAdded(application: application, feature: feature)
    }
}
