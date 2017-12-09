//
//  AnyApplication.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Wireframe_Core

// some base class needed for type erasure, ignore it if possible
class _AnyApplication<AppState> : ApplicationType{
    
    typealias ApplicationState = AppState
    
    var state: ObservableProperty<ApplicationState> {
        fatalError("override me")
    }
    
    var wireframe : Wireframe {
        fatalError("override me")
    }
    
    var redux : Redux<ApplicationState> {
        fatalError("override me")
    }

    func add(feature: Feature) throws {
        fatalError("override me")
    }
    
    func add<T: FeatureObserverType>(featureObserver: T) where T.ApplicationState == ApplicationState {
        fatalError("override me")
    }
    
}

// some box class needed for type erasure, ignore it if possible
final class _AnyApplicationBox<Base: ApplicationType>: _AnyApplication<Base.ApplicationState> {
    
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override var state: ObservableProperty<ApplicationState> {
        return self.base.state
    }
    
    override var wireframe: Wireframe {
        return self.base.wireframe
    }
    
    override var redux: Redux<Base.ApplicationState> {
        return self.base.redux
    }
    
    override func add(feature: Feature) throws {
        try self.base.add(feature: feature)
    }
    
    override func add<T: FeatureObserverType>(featureObserver: T) where Base.ApplicationState == T.ApplicationState {
        self.base.add(featureObserver: featureObserver)
    }
    
}


/// Type erasure for the generic ApplicationType protocol
/// (you need this to reference it as a full type, to use it in arrays or variable definitions,
/// since generic protocols can only be used in generic definitions)
open class AnyApplication<AppState> : ApplicationType {
    
    public typealias ApplicationState = AppState
    
    private let box: _AnyApplication<AppState>
    
    public init<Base: ApplicationType>(_ base: Base) where Base.ApplicationState == AppState {
        box = _AnyApplicationBox(base)
    }
    
    open var state: ObservableProperty<ApplicationState> {
        return self.box.state
    }
    
    open var wireframe: Wireframe {
        return self.box.wireframe
    }
    
    open var redux: Redux<AppState> {
        return self.box.redux
    }
    
    open func add(feature: Feature) throws {
        try self.box.add(feature: feature)
    }
    
    open func add<T: FeatureObserverType>(featureObserver: T) where AppState == T.ApplicationState {
        self.box.add(featureObserver: featureObserver)
    }
    
}
