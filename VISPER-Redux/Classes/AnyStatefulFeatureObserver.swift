//
//  AnyFeatureObserver.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Core

// some base class needed for type erasure, ignore it if possible
class _AnyStatefulFeatureObserver<ApplicationState> : StatefulFeatureObserver{
    
    typealias AppState = ApplicationState

    func featureAdded(application: AnyReduxApp<AppState>, feature: Feature) throws {
        fatalError("override me")
    }
}

// some box class needed for type erasure, ignore it if possible
final class _AnyStatefulFeatureObserverBox<Base: StatefulFeatureObserver>: _AnyStatefulFeatureObserver<Base.AppState> {
    
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override func featureAdded(application: AnyReduxApp<Base.AppState>, feature: Feature) throws {
        try self.base.featureAdded(application: application, feature: feature)
    }
}

/// Type erasure for the generic FeatureObserverType protocol
/// (you need this to reference it as a full type, to use it in arrays or variable definitions,
/// since generic protocols can only be used in generic definitions)
open class AnyStatefulFeatureObserver<ApplicationState> : StatefulFeatureObserver {
    
    public typealias AppState = ApplicationState
    
    private let box: _AnyStatefulFeatureObserver<AppState>
    
    public init<Base: StatefulFeatureObserver>(_ base: Base) where Base.AppState == ApplicationState{
        box = _AnyStatefulFeatureObserverBox(base)
    }
    
    open func featureAdded(application: AnyReduxApp<ApplicationState>, feature: Feature) throws {
        try self.box.featureAdded(application: application, feature: feature)
    }
}
