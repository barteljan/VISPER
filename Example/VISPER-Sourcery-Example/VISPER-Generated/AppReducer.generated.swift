// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Generated by AppReducer.stencil

import VISPER_Redux
import VISPER_Core

// AppReducer for AppState
let appReducerForAppState: AppReducer<AppState> = { (reducerProvider: ReducerProvider, action: Action, state: AppState) -> AppState in
    var newState = AppState(styleState: reducerProvider.reduce(action: action, state: state.styleState),
        userState: reducerProvider.reduce(action: action, state: state.userState))
    newState = reducerProvider.reduce(action: action, state: newState)
    return newState
}
