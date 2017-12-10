//
//  AnyApplication.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Reactive
import VISPER_Core

// some base class needed for type erasure, ignore it if possible
class _AnyApplication<ObservableProperty: ObservablePropertyType> : ApplicationType{
    
    typealias ApplicationState = ObservableProperty.ValueType
    
    var state: ObservableProperty {
        fatalError("override me")
    }
    
    var wireframe : Wireframe {
        fatalError("override me")
    }
    
    var redux : Redux<ObservableProperty> {
        fatalError("override me")
    }

    func add(feature: Feature) throws {
        fatalError("override me")
    }
    
    func add<T: FeatureObserverType>(featureObserver: T) where T.ObservableProperty == ObservableProperty {
        fatalError("override me")
    }
    
}

// some box class needed for type erasure, ignore it if possible
final class _AnyApplicationBox<Base: ApplicationType>: _AnyApplication<Base.ApplicationObservableProperty> {
    
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override var state: Base.ApplicationObservableProperty {
        return self.base.state
    }
    
    override var wireframe: Wireframe {
        return self.base.wireframe
    }
    
    override var redux: Redux<Base.ApplicationObservableProperty> {
        return self.base.redux
    }
    
    override func add(feature: Feature) throws {
        try self.base.add(feature: feature)
    }
    
    override func add<T: FeatureObserverType>(featureObserver: T) where Base.ApplicationObservableProperty == T.ObservableProperty {
        self.base.add(featureObserver: featureObserver)
    }
    
}


/// Type erasure for the generic ApplicationType protocol
/// (you need this to reference it as a full type, to use it in arrays or variable definitions,
/// since generic protocols can only be used in generic definitions)
open class AnyApplication<ObservableProperty: ObservablePropertyType> : ApplicationType {
    
    public typealias ApplicationObservableProperty = ObservableProperty
    
    private let box: _AnyApplication<ObservableProperty>
    
    public init<Base: ApplicationType>(_ base: Base) where Base.ApplicationObservableProperty == ObservableProperty {
        box = _AnyApplicationBox(base)
    }
    
    open var state: ObservableProperty {
        return self.box.state
    }
    
    open var wireframe: Wireframe {
        return self.box.wireframe
    }
    
    open var redux: Redux<ObservableProperty> {
        return self.box.redux
    }
    
    open func add(feature: Feature) throws {
        try self.box.add(feature: feature)
    }
    
    open func add<T: FeatureObserverType>(featureObserver: T) where T.ObservableProperty == ObservableProperty {
        self.box.add(featureObserver: featureObserver)
    }
    
}
