//
//  Bridge-Swift.swift
//  Pods-VISPER-Reactive-Example
//
//  Created by bartel on 06.01.18.
//

import Foundation
import VISPER_Swift

public typealias AnyVISPERApp<AppState> = VISPER_Swift.AnyVISPERApp<AppState>
public typealias VISPERApp<AppState> = VISPER_Swift.VISPERApp<AppState>
public typealias ApplicationFactory<AppState> = VISPER_Swift.ApplicationFactory<AppState>
public typealias VISPERAppType = VISPER_Swift.VISPERAppType
public typealias DefaultStatefulFeature<State> = VISPER_Swift.DefaultStatefulFeature<State>
public typealias StatefulFeature = VISPER_Swift.StatefulFeature
public typealias StateObservingFeature<ObservedStateType> = VISPER_Swift.StateObservingFeature<ObservedStateType>
public typealias StateObservingFeatureObserver<ApplicationState,ObservedState> = VISPER_Swift.StateObservingFeatureObserver<ApplicationState,ObservedState>

@available(*, unavailable, message: "replace this class with AnyVISPERApp",renamed: "AnyVISPERApp")
public typealias AnyApplication<AppState> = AnyVISPERApp<AppState>

@available(*, unavailable, message: "replace this interface with VISPERAppType",renamed: "VISPERAppType")
public typealias ApplicationType = VISPERAppType

@available(*, unavailable, message: "replace this class with VISPERApp",renamed: "VISPERApp")
public typealias Application<AppState> = VISPERApp<AppState>
