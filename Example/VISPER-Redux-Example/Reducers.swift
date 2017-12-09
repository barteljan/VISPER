//
//  Reducers.swift
//  VISPER-Redux_Example
//
//  Created by bartel on 01.11.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Redux

let incrementReducer = { (provider : ReducerProvider, action: IncrementAction, state: CounterState) -> CounterState in
    return CounterState(counter: state.counter + 1)
}


class DecrementReducer : ActionReducerType {
    
    typealias ReducerStateType = CounterState
    typealias ReducerActionType = DecrementAction
    
    func reduce(provider: ReducerProvider,
                action: ReducerActionType,
                state: ReducerStateType) -> ReducerStateType{
        return CounterState(counter: state.counter-1)
    }
}


