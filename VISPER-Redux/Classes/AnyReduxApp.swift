//
//  File.swift
//  VISPER-Redux
//
//  Created by bartel on 04.07.18.
//

import Foundation
import VISPER_Core
import VISPER_Reactive

// some base class needed for type erasure, ignore it if possible
class _AnyApplication<AppState> : ReduxApp{
    
    typealias ApplicationState = AppState
    
    var state: ObservableProperty<AppState> {
        fatalError("override me")
    }
    
    var redux : Redux<AppState> {
        fatalError("override me")
    }
    
    func add(feature: Feature) throws {
        fatalError("override me")
    }
    
    func add(featureObserver: FeatureObserver) {
        fatalError("override me")
    }
    
    func add<T: StatefulFeatureObserver>(featureObserver: T) where T.AppState == AppState {
        fatalError("override me")
    }
    
}

// some box class needed for type erasure, ignore it if possible
final class _AnyApplicationBox<Base: ReduxApp>: _AnyApplication<Base.ApplicationState> {
    
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override var state: ObservableProperty<Base.ApplicationState> {
        return self.base.state
    }
    
    override var redux: Redux<Base.ApplicationState> {
        return self.base.redux
    }
    
    override func add(feature: Feature) throws {
        try self.base.add(feature: feature)
    }
    
    override func add(featureObserver: FeatureObserver) {
        self.base.add(featureObserver: featureObserver)
    }
    
    override func add<T: StatefulFeatureObserver>(featureObserver: T) where Base.ApplicationState == T.AppState {
        self.base.add(featureObserver: featureObserver)
    }
    
}

/// Type erasure for the generic ApplicationType protocol
/// (you need this to reference it as a full type, to use it in arrays or variable definitions,
/// since generic protocols can only be used in generic definitions)
open class AnyReduxApp<AppState> : ReduxApp {
    
    public typealias ApplicationState = AppState
    
    private let box: _AnyApplication<AppState>
    
    public init<Base: ReduxApp>(_ base: Base) where Base.ApplicationState == AppState {
        box = _AnyApplicationBox(base)
    }
    
    open var state: ObservableProperty<AppState> {
        return self.box.state
    }
    
    open var redux: Redux<AppState> {
        return self.box.redux
    }
    
    open func add(feature: Feature) throws {
        try self.box.add(feature: feature)
    }
    
    public func add(featureObserver: FeatureObserver) {
        self.box.add(featureObserver: featureObserver)
    }
    
    open func add<T: StatefulFeatureObserver>(featureObserver: T) where T.AppState == AppState {
        self.box.add(featureObserver: featureObserver)
    }
    
}
