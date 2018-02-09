//
//  AnyApplication.swift
//  SwiftyVISPER
//
//  Created by bartel on 18.11.17.
//

import Foundation
import VISPER_Redux
import VISPER_Core
import VISPER_Reactive

// some base class needed for type erasure, ignore it if possible
class _AnyApplication<AppState> : ApplicationType{
   
    

    typealias ApplicationState = AppState
    
    var state: ObservableProperty<AppState> {
        fatalError("override me")
    }
    
    var wireframe : Wireframe {
        fatalError("override me")
    }
    
    var redux : Redux<AppState> {
        fatalError("override me")
    }

    func add(feature: Feature) throws {
        fatalError("override me")
    }
    
    func add<T: FeatureObserverType>(featureObserver: T) where T.AppState == AppState {
        fatalError("override me")
    }
    
    func add(controllerToNavigate: UIViewController) {
        fatalError("override me")
    }
    
    func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        fatalError("override me")
    }
    
}

// some box class needed for type erasure, ignore it if possible
final class _AnyApplicationBox<Base: ApplicationType>: _AnyApplication<Base.ApplicationState> {
    
    var base: Base
    
    init(_ base: Base) { self.base = base }
    
    override var state: ObservableProperty<Base.ApplicationState> {
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
    
    override func add<T: FeatureObserverType>(featureObserver: T) where Base.ApplicationState == T.AppState {
        self.base.add(featureObserver: featureObserver)
    }
    
    override func add(controllerToNavigate: UIViewController) {
        self.base.add(controllerToNavigate: controllerToNavigate)
    }
    
    override func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        return self.base.controllerToNavigate(matches: matches)
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
    
    open var state: ObservableProperty<AppState> {
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
    
    open func add<T: FeatureObserverType>(featureObserver: T) where T.AppState == AppState {
        self.box.add(featureObserver: featureObserver)
    }
    
    public func add(controllerToNavigate: UIViewController) {
        self.box.add(controllerToNavigate: controllerToNavigate)
    }
    
    public func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        return self.box.controllerToNavigate(matches: matches)
    }
    
}
