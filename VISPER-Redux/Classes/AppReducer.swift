//
//  AppReducer.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation
import VISPER_Core

public typealias AppReducer<State> = (_ ReducerProvider: ReducerProvider,_ action: Action, _ state: State) -> State
