//
//  Reducers.swift
//  VISPER-Redux_Example
//
//  Created by bartel on 01.11.17.
//  Copyright © 2017 Jan Bartel. All rights reserved.
//

import Foundation
import VISPER_Reactive
import VISPER_Redux

let incrementReducer = { (provider : ReducerProvider, action: IncrementAction, state: CounterState) -> CounterState in
    return CounterState(counter: state.counter + 1)
}


class DecrementReducer : AsyncActionReducerType {
    
    typealias ReducerStateType = CounterState
    typealias ReducerActionType = DecrementAction
    
    let state: ObservableProperty<CounterState>
    
    init(state: ObservableProperty<CounterState>){
        self.state = state
    }
    
    func reduce(provider: ReducerProvider,
                  action: DecrementAction,
              completion: @escaping (CounterState) -> Void) {
        let newState =  CounterState(counter: state.value.counter-1)
        completion(newState)
    }
    
}

class CounterStateReducer: ActionReducerType {
    
    typealias ReducerStateType  = AppState
    typealias ReducerActionType = UpdateStateWithSubStateAction<CounterState>
    
    func reduce(provider: ReducerProvider,
                  action: UpdateStateWithSubStateAction<CounterState>,
                   state: AppState) -> AppState {
        return AppState(counterState: action.subState)
    }
    
    
}

