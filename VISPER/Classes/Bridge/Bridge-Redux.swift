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
public typealias AppReducer<State> = VISPER_Redux.AppReducer<State>
public typealias FunctionalReducer<StateType,ActionType : Action> = VISPER_Redux.FunctionalReducer<StateType,ActionType>
public typealias Middleware<State> = VISPER_Redux.Middleware<State>
public typealias ReducerContainer = VISPER_Redux.ReducerContainer
public typealias ReducerProvider = VISPER_Redux.ReducerProvider
public typealias Redux<State> = VISPER_Redux.Redux<State>
public typealias Store<State>  = VISPER_Redux.Store<State>
