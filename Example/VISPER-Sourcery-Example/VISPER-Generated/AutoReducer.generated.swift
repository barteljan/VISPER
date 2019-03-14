// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import VISPER_Redux
import VISPER_Core



//
//
// AppState
//
//

//
// Set AppState styleState
//

// Set AppState styleState Action
internal struct AppStateSetStylestateAction: Action {
    let styleState: StyleState
    internal init(styleState: StyleState) {
        self.styleState = styleState
    }
}

// Set AppState styleState Action Reducer
internal class AppStateSetStylestateReducer: ActionReducerType {
    public typealias ReducerStateType = AppState
    public typealias ReducerActionType = AppStateSetStylestateAction
    public func reduce(provider: ReducerProvider,
                         action: AppStateSetStylestateAction,
                          state: AppState) -> AppState {
        if let newState = AppState(sourceObject: state, styleState: action.styleState) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set AppState userState
//

// Set AppState userState Action
internal struct AppStateSetUserstateAction: Action {
    let userState: UserState?
    internal init(userState: UserState?) {
        self.userState = userState
    }
}

// Set AppState userState Action Reducer
internal class AppStateSetUserstateReducer: ActionReducerType {
    public typealias ReducerStateType = AppState
    public typealias ReducerActionType = AppStateSetUserstateAction
    public func reduce(provider: ReducerProvider,
                         action: AppStateSetUserstateAction,
                          state: AppState) -> AppState {
        if let newState = AppState(sourceObject: state, userState: action.userState) {
            return newState
        } else {
            return state
        }
    }
}


//
//
// StyleState
//
//

//
// Set StyleState backgroundColor
//

// Set StyleState backgroundColor Action
internal struct StyleStateSetBackgroundcolorAction: Action {
    let backgroundColor: UIColor
    internal init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}

// Set StyleState backgroundColor Action Reducer
internal class StyleStateSetBackgroundcolorReducer: ActionReducerType {
    public typealias ReducerStateType = StyleState
    public typealias ReducerActionType = StyleStateSetBackgroundcolorAction
    public func reduce(provider: ReducerProvider,
                         action: StyleStateSetBackgroundcolorAction,
                          state: StyleState) -> StyleState {
        if let newState = StyleState(sourceObject: state, backgroundColor: action.backgroundColor) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set StyleState fontColor
//

// Set StyleState fontColor Action
internal struct StyleStateSetFontcolorAction: Action {
    let fontColor: UIColor
    internal init(fontColor: UIColor) {
        self.fontColor = fontColor
    }
}

// Set StyleState fontColor Action Reducer
internal class StyleStateSetFontcolorReducer: ActionReducerType {
    public typealias ReducerStateType = StyleState
    public typealias ReducerActionType = StyleStateSetFontcolorAction
    public func reduce(provider: ReducerProvider,
                         action: StyleStateSetFontcolorAction,
                          state: StyleState) -> StyleState {
        if let newState = StyleState(sourceObject: state, fontColor: action.fontColor) {
            return newState
        } else {
            return state
        }
    }
}


//
//
// UserState
//
//

//
// Set UserState firstName
//

// Set UserState firstName Action
internal struct UserStateSetFirstnameAction: Action {
    let firstName: String?
    internal init(firstName: String?) {
        self.firstName = firstName
    }
}

// Set UserState firstName Action Reducer
internal class UserStateSetFirstnameReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetFirstnameAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetFirstnameAction,
                          state: UserState) -> UserState {
        if let newState = UserState(sourceObject: state, firstName: action.firstName) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set UserState lastName
//

// Set UserState lastName Action
internal struct UserStateSetLastnameAction: Action {
    let lastName: String?
    internal init(lastName: String?) {
        self.lastName = lastName
    }
}

// Set UserState lastName Action Reducer
internal class UserStateSetLastnameReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetLastnameAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetLastnameAction,
                          state: UserState) -> UserState {
        if let newState = UserState(sourceObject: state, lastName: action.lastName) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set UserState userName
//

// Set UserState userName Action
internal struct UserStateSetUsernameAction: Action {
    let userName: String
    internal init(userName: String) {
        self.userName = userName
    }
}

// Set UserState userName Action Reducer
internal class UserStateSetUsernameReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetUsernameAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetUsernameAction,
                          state: UserState) -> UserState {
        if let newState = UserState(sourceObject: state, userName: action.userName) {
            return newState
        } else {
            return state
        }
    }
}


//
// Set UserState email
//

// Set UserState email Action
internal struct UserStateSetEmailAction: Action {
    let email: String?
    internal init(email: String?) {
        self.email = email
    }
}

// Set UserState email Action Reducer
internal class UserStateSetEmailReducer: ActionReducerType {
    public typealias ReducerStateType = UserState
    public typealias ReducerActionType = UserStateSetEmailAction
    public func reduce(provider: ReducerProvider,
                         action: UserStateSetEmailAction,
                          state: UserState) -> UserState {
        if let newState = UserState(sourceObject: state, email: action.email) {
            return newState
        } else {
            return state
        }
    }
}








