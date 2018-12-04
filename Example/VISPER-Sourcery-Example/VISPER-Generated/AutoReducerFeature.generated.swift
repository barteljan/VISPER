// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import VISPER_Swift
import VISPER_Redux
//
//
// Feature to add all auto generated reducers
//
//
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
