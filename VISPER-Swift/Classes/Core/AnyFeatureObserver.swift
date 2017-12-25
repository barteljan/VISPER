//
//  AnyFeatureObserver.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Core

// some base class needed for type erasure, ignore it if possible
class _AnyFeatureObserver<ObserverObservableProperty: ObservablePropertyType> : FeatureObserverType{
    
    typealias ObservableProperty = ObserverObservableProperty

    func featureAdded(application: Application<ObservableProperty>, feature: Feature) throws {
        fatalError("override me")
    }
}

// some box class needed for type erasure, ignore it if possible
final class _AnyFeatureObserverBox<Base: FeatureObserverType>: _AnyFeatureObserver<Base.ObservableProperty> {
    
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override func featureAdded(application: Application<ObservableProperty>, feature: Feature) throws {
        try self.base.featureAdded(application: application, feature: feature)
    }
}

/// Type erasure for the generic FeatureObserverType protocol
/// (you need this to reference it as a full type, to use it in arrays or variable definitions,
/// since generic protocols can only be used in generic definitions)
open class AnyFeatureObserver<ObserverObservableProperty: ObservablePropertyType> : FeatureObserverType {
    
    public typealias ObservableProperty = ObserverObservableProperty
    
    private let box: _AnyFeatureObserver<ObservableProperty>
    
    public init<Base: FeatureObserverType>(_ base: Base) where Base.ObservableProperty == ObserverObservableProperty{
        box = _AnyFeatureObserverBox(base)
    }
    
    open func featureAdded(application: Application<ObservableProperty>, feature: Feature) throws {
        try self.box.featureAdded(application: application, feature: feature)
    }
}
