// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Generated by AutoReducerFeature.stencil

import VISPER_Swift
import VISPER_Redux

// "soucery-internal" - most likely not relevant to developers, because it is created and used in Application Factory automatically.

class AutoReducerFeature: LogicFeature {
    func injectReducers(container: ReducerContainer) {

        // AppState
        container.addReducer(reducer: AppStateSetStylestateReducer())
        container.addReducer(reducer: AppStateSetUserstateReducer())

        // StyleState
        container.addReducer(reducer: StyleStateSetBackgroundcolorReducer())
        container.addReducer(reducer: StyleStateSetFontcolorReducer())

        // UserState
        container.addReducer(reducer: UserStateSetFirstnameReducer())
        container.addReducer(reducer: UserStateSetLastnameReducer())
        container.addReducer(reducer: UserStateSetUsernameReducer())
        container.addReducer(reducer: UserStateSetEmailReducer())
    }
}
