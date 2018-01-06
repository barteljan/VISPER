//
//  Bridge-Swift.swift
//  Pods-VISPER-Reactive-Example
//
//  Created by bartel on 06.01.18.
//

import Foundation
import VISPER_Swift

public typealias AnyApplication<AppState> = VISPER_Swift.AnyApplication<AppState>
public typealias AnyFeatureObserver<ApplicationState> = VISPER_Swift.AnyFeatureObserver<ApplicationState>
public typealias Application<AppState> = VISPER_Swift.Application<AppState>
public typealias ApplicationFactory<AppState> = VISPER_Swift.ApplicationFactory<AppState>
public typealias ApplicationType = VISPER_Swift.ApplicationType
public typealias DefaultStatefulFeature<State> = VISPER_Swift.DefaultStatefulFeature<State>
public typealias Feature = VISPER_Swift.Feature
public typealias FeatureObserverType = VISPER_Swift.FeatureObserverType
public typealias LogicFeature = VISPER_Swift.LogicFeature
public typealias LogicFeatureObserver<ApplicationState> = VISPER_Swift.LogicFeatureObserver<ApplicationState>
public typealias PresenterFeature = VISPER_Swift.PresenterFeature
public typealias PresenterFeatureObserver<ApplicationState> = VISPER_Swift.PresenterFeatureObserver<ApplicationState>
public typealias StatefulFeature = VISPER_Swift.StatefulFeature
public typealias ViewFeature = VISPER_Swift.ViewFeature
public typealias ViewFeatureObserver<ApplicationState> = VISPER_Swift.ViewFeatureObserver<ApplicationState>
