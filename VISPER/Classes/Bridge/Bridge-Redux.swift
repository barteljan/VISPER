//
//  Bridge-Redux.swift
//  VISPER
//
//  Created by bartel on 06.01.18.
//

import Foundation
import VISPER_Redux

public typealias ActionReducer<StateType,ActionType: Action> = VISPER_Redux.ActionReducer<StateType,ActionType>
public typealias ActionReducerType = VISPER_Redux.ActionReducerType
public typealias AnyActionReducer = VISPER_Redux.AnyActionReducer
public typealias AnyAsyncActionReducer = VISPER_Redux.AnyAsyncActionReducer
public typealias AnyReduxApp<ApplicationState> = VISPER_Redux.AnyReduxApp<ApplicationState>
public typealias AnyStatefulFeatureObserver<ApplicationState> = VISPER_Redux.AnyStatefulFeatureObserver<ApplicationState>
public typealias AppReducer<State> = VISPER_Redux.AppReducer<State>
public typealias AsyncActionReducer<StateType,ActionType: Action> = VISPER_Redux.AsyncActionReducer<StateType,ActionType>
public typealias AsyncActionReducerType = VISPER_Redux.AsyncActionReducerType
public typealias DefaultReduxApp<ApplicationState> = VISPER_Redux.DefaultReduxApp<ApplicationState>
public typealias FunctionalReducer<StateType,ActionType : Action> = VISPER_Redux.FunctionalReducer<StateType,ActionType>
public typealias LogicFeature = VISPER_Redux.LogicFeature
public typealias LogicFeatureObserver<ApplicationState> = VISPER_Redux.LogicFeatureObserver<ApplicationState>
public typealias Middleware<State> = VISPER_Redux.Middleware<State>
public typealias ReducerContainer = VISPER_Redux.ReducerContainer
public typealias ReducerProvider = VISPER_Redux.ReducerProvider
public typealias Redux<State> = VISPER_Redux.Redux<State>
public typealias ReduxApp = VISPER_Redux.ReduxApp
public typealias StatefulFeatureObserver = VISPER_Redux.StatefulFeatureObserver
public typealias Store<State>  = VISPER_Redux.Store<State>
public typealias StateObservingFeatureObserver<ApplicationState,ObservedState> = VISPER_Redux.StateObservingFeatureObserver<ApplicationState,ObservedState>
public typealias StateObservingFeature<ObservedStateType> = VISPER_Redux.StateObservingFeature<ObservedStateType>
public typealias StateObservingFeatureError = VISPER_Redux.StateObservingFeatureError
