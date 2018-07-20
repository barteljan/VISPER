//
//  Bridge-Swift.swift
//  Pods-VISPER-Reactive-Example
//
//  Created by bartel on 06.01.18.
//

import Foundation
import VISPER_Swift

@available(*, deprecated,renamed: "AppFactory")
public typealias ApplicationFactory<AppState> = VISPER_Swift.AppFactory<AppState>
public typealias AnyVISPERApp<AppState> = VISPER_Swift.AnyVISPERApp<AppState>
public typealias VISPERApp<AppState> = VISPER_Swift.VISPERApp<AppState>
public typealias AppFactory<AppState> = VISPER_Swift.AppFactory<AppState>
public typealias VISPERAppType = VISPER_Swift.VISPERAppType
public typealias DefaultStatefulFeature<State> = VISPER_Swift.DefaultStatefulFeature<State>
public typealias StatefulFeature = VISPER_Swift.StatefulFeature

@available(*, unavailable, message: "replace this class with AnyVISPERApp",renamed: "AnyVISPERApp")
public typealias AnyApplication<AppState> = AnyVISPERApp<AppState>

@available(*, unavailable, message: "replace this interface with VISPERAppType",renamed: "VISPERAppType")
public typealias ApplicationType = VISPERAppType

@available(*, unavailable, message: "replace this class with VISPERApp",renamed: "VISPERApp")
public typealias Application<AppState> = VISPERApp<AppState>
