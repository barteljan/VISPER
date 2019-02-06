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
import VISPER_Wireframe

// some base class needed for type erasure, ignore it if possible
class _AnyApplication<AppState> : VISPERAppType{
    
    
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
    
    func add(featureObserver: FeatureObserver) {
         fatalError("override me")
    }

    func add<T: StatefulFeatureObserver>(featureObserver: T) where T.AppState == AppState {
        fatalError("override me")
    }
    
    func add(featureObserver: WireframeFeatureObserver) {
        fatalError("override me")
    }
    
    func navigateOn(_ controller: UIViewController) {
        fatalError("override me")
    }
    
    func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        fatalError("override me")
    }
    
}

// some box class needed for type erasure, ignore it if possible
final class _AnyApplicationBox<Base: VISPERAppType>: _AnyApplication<Base.ApplicationState> {
    
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
    
    override func add<T: StatefulFeatureObserver>(featureObserver: T) where Base.ApplicationState == T.AppState {
        self.base.add(featureObserver: featureObserver)
    }
    
    override func add(featureObserver: FeatureObserver) {
        self.base.add(featureObserver: featureObserver)
    }
    
    
    override func add(featureObserver: WireframeFeatureObserver) {
        self.base.add(featureObserver: featureObserver)
    }
    
    
    override func navigateOn(_ controller: UIViewController) {
        self.base.navigateOn(controller)
    }
    
    override func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        return self.base.controllerToNavigate(matches: matches)
    }
    
}

@available(*, unavailable, message: "replace this class with AnyVISPERApp",renamed: "AnyVISPERApp")
public typealias AnyApplication<AppState> = AnyVISPERApp<AppState>

/// Type erasure for the generic ApplicationType protocol
/// (you need this to reference it as a full type, to use it in arrays or variable definitions,
/// since generic protocols can only be used in generic definitions)
open class AnyVISPERApp<AppState> : VISPERAppType {
    
    public typealias ApplicationState = AppState
    
    private let box: _AnyApplication<AppState>
    
    public init<Base: VISPERAppType>(_ base: Base) where Base.ApplicationState == AppState {
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
    
    public func add(featureObserver: FeatureObserver) {
        self.box.add(featureObserver: featureObserver)
    }
    
    open func add<T: StatefulFeatureObserver>(featureObserver: T) where T.AppState == AppState {
        self.box.add(featureObserver: featureObserver)
    }
    
    open func add(featureObserver: WireframeFeatureObserver) {
        self.box.add(featureObserver: featureObserver)
    }
    
    open func navigateOn(_ controller: UIViewController) {
        self.box.navigateOn(controller)
    }
    
    public func controllerToNavigate(matches: (UIViewController?) -> Bool) -> UIViewController? {
        return self.box.controllerToNavigate(matches: matches)
    }
    
}
